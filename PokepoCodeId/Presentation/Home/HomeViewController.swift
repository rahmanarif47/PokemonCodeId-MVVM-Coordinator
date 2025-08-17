//
//  HomeViewController.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController {
    private let vm: HomeViewModel
    private let bag = DisposeBag()

    private let table = UITableView()
    private let searchBtn = UIBarButtonItem(systemItem: .search)

    init(viewModel: HomeViewModel) {
        self.vm = viewModel
        super.init(nibName: nil, bundle: nil)
        self.title = "Home"
    }
    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = searchBtn
        setupTable()

        vm.items.bind(to: table.rx.items(cellIdentifier: PokemonCell.reuse, cellType: PokemonCell.self)) { _, item, cell in
            cell.fill(item)
        }.disposed(by: bag)

        table.rx.modelSelected(PokemonListItem.self)
            .subscribe(onNext: { [weak self] item in
                self?.openDetailByName(item.name)
            }).disposed(by: bag)

        vm.isLoading.asDriver().drive(onNext: { [weak self] loading in
            loading ? self?.showHUD("Loading...") : self?.hideHUD()
        }).disposed(by: bag)

        vm.error.subscribe(onNext: { [weak self] msg in
            self?.showAlert(msg)
        }).disposed(by: bag)

        vm.openDetail.subscribe(onNext: { [weak self] detail in
            let vc = PokemonDetailViewController(viewModel: .init(initialDetail: detail))
            self?.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: bag)

        // Pagination trigger (infinite scroll)
        table.rx.contentOffset
            .map { [weak self] offset -> Bool in
                guard let self else { return false }
                let threshold = max(0.0, self.table.contentSize.height - self.table.bounds.size.height - 120)
                return offset.y > threshold
            }
            .distinctUntilChanged()
            .filter { $0 }
            .map { _ in () }
            .bind(to: vm.loadNextPage)
            .disposed(by: bag)

        // initial load
        vm.refresh.accept(())
        bindSearch()
    }

    private func setupTable() {
        table.register(PokemonCell.self, forCellReuseIdentifier: PokemonCell.reuse)
        table.tableFooterView = UIView()
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func bindSearch() {
        searchBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.presentSearch()
        }).disposed(by: bag)
    }

    private func presentSearch() {
        let alert = UIAlertController(title: "Search Pokemon", message: "Enter name", preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Search", style: .default, handler: { [weak self] _ in
            let name = alert.textFields?.first?.text ?? ""
            guard !name.isEmpty else { return }
            self?.vm.searchTapped.accept(name)
        }))
        present(alert, animated: true)
    }

    private func openDetailByName(_ name: String) {
        // Jika dari list, fetch detail dulu lalu push
        showHUD("Loading...")
        DIContainer().getDetailUC.execute(name: name)
            .subscribe { [weak self] detail in
                self?.hideHUD()
                let vc = PokemonDetailViewController(viewModel: .init(initialDetail: detail))
                self?.navigationController?.pushViewController(vc, animated: true)
            } onFailure: { [weak self] err in
                self?.hideHUD()
                self?.showAlert(err.localizedDescription)
            }.disposed(by: bag)
    }
}
