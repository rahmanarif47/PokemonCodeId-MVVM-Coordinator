//
//  HomeViewModel.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import RxSwift
import RxCocoa

final class HomeViewModel {
    let items = BehaviorRelay<[PokemonListItem]>(value: [])
    let isLoading = BehaviorRelay<Bool>(value: false)
    let error = PublishRelay<String>()
    let loadNextPage = PublishRelay<Void>()
    let refresh = PublishRelay<Void>()
    let searchTapped = PublishRelay<String>() // name

    private let pageSize = 10
    private var currentPage = 0
    private var isLastPage = false
    private let bag = DisposeBag()

    private let getPageUC: GetPokemonPageUseCase
    private let searchUC: SearchPokemonByNameUseCase

    let openDetail = PublishRelay<PokemonDetail>() // emit detail for navigation

    init(getPageUC: GetPokemonPageUseCase, searchUC: SearchPokemonByNameUseCase) {
        self.getPageUC = getPageUC; self.searchUC = searchUC

        // initial load
        refresh
            .startWith(())
            .flatMapLatest { [unowned self] _ -> Observable<Event<[PokemonListItem]>> in
                self.currentPage = 0; self.isLastPage = false
                self.isLoading.accept(true)
                return self.getPageUC.execute(limit: self.pageSize, page: 0).asObservable().materialize()
            }
            .subscribe(onNext: { [weak self] ev in
                guard let self else { return }
                self.isLoading.accept(false)
                switch ev {
                case .next(let data):
                    self.items.accept(data)
                    self.isLastPage = data.count < self.pageSize
                case .error(let err): self.error.accept(err.localizedDescription)
                default: break
                }
            }).disposed(by: bag)

        // pagination
        loadNextPage
            .filter { [unowned self] in !self.isLoading.value && !self.isLastPage }
            .flatMapLatest { [unowned self] _ -> Observable<Event<[PokemonListItem]>> in
                self.isLoading.accept(true)
                let next = self.currentPage + 1
                return self.getPageUC.execute(limit: self.pageSize, page: next).asObservable()
                    .do(onNext: { _ in self.currentPage = next })
                    .materialize()
            }
            .subscribe(onNext: { [weak self] ev in
                guard let self else { return }
                self.isLoading.accept(false)
                switch ev {
                case .next(let data):
                    self.items.accept(self.items.value + data)
                    self.isLastPage = data.count < self.pageSize
                case .error(let err): self.error.accept(err.localizedDescription)
                default: break
                }
            }).disposed(by: bag)

        // search -> fetch detail & open
        searchTapped
            .flatMapLatest { [unowned self] name in
                self.isLoading.accept(true)
                return self.searchUC.execute(name: name).asObservable().materialize()
            }
            .subscribe(onNext: { [weak self] ev in
                guard let self else { return }
                self.isLoading.accept(false)
                switch ev {
                case .next(let detail): self.openDetail.accept(detail)
                case .error: self.error.accept("Pokemon not found")
                default: break
                }
            }).disposed(by: bag)
    }
}
