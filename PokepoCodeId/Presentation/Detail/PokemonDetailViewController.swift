//
//  PokemonDetailViewController.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import UIKit
import RxSwift

final class PokemonDetailViewController: UIViewController {
    private let vm: PokemonDetailViewModel
    private let bag = DisposeBag()
    private let nameLabel = UILabel()
    private let abilitiesLabel = UILabel()

    init(viewModel: PokemonDetailViewModel) {
        self.vm = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "Detail"
    }
    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        vm.name.bind(to: nameLabel.rx.text).disposed(by: bag)
        vm.abilities.map { $0.joined(separator: ", ") }.bind(to: abilitiesLabel.rx.text).disposed(by: bag)
    }

    private func setupUI() {
        nameLabel.font = .boldSystemFont(ofSize: 22)
        abilitiesLabel.numberOfLines = 0

        let stack = UIStackView(arrangedSubviews: [nameLabel, abilitiesLabel])
        stack.axis = .vertical; stack.spacing = 8
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
}
