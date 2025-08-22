//
//  PokemonRepositoryImpl.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import RxSwift

final class PokemonRepositoryImpl: PokemonRepository {
    private let remote = PokemonRemoteDataSource()
    private let local = PokemonLocalDataSource()

    func fetchPage(limit: Int, page: Int) -> Single<[PokemonListItem]> {
        remote.fetchPage(limit: limit, page: page)
            .do(onSuccess: { self.local.savePage(items: $0, page: page) })
            .catch { _ in
                let cached = self.local.loadPage(page: page, limit: limit)
                return cached.isEmpty ? .error(APIError.unknown) : .just(cached)
            }
    }

    func fetchDetail(name: String) -> Single<PokemonDetail> {
        remote.fetchDetail(name: name)
            .do(onSuccess: { self.local.saveDetail($0) })
            .catch { _ in
                if let cached = self.local.loadDetail(name: name) {
                    return .just(cached)
                }
                return .error(APIError.notFound)
            }
    }

    func searchByName(_ name: String) -> Single<PokemonDetail> {
        fetchDetail(name: name)
    }
}
