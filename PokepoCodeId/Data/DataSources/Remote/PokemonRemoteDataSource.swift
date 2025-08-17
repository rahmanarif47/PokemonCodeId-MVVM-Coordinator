//
//  PokemonRemoteDataSource.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import RxSwift

final class PokemonRemoteDataSource {
    func fetchPage(limit: Int, page: Int) -> Single<[PokemonListItem]> {
        let offset = page * limit
        let url = PokeAPI.base.appendingPathComponent("pokemon")
        return AFSession.shared.get(PokeAPI.ListResponse.self, url: url, params: ["limit": limit, "offset": offset])
            .map { $0.results.map { PokemonListItem(name: $0.name) } }
    }

    func fetchDetail(name: String) -> Single<PokemonDetail> {
        let url = PokeAPI.base.appendingPathComponent("pokemon/\(name.lowercased())")
        return AFSession.shared.get(PokeAPI.PokemonDetailResponse.self, url: url)
            .map { resp in
                PokemonDetail(
                    name: resp.name,
                    abilities: resp.abilities.map { $0.ability.name }
                )
            }
    }
}
