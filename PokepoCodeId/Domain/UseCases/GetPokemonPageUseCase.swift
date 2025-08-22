//
//  GetPokemonPageUseCase.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import RxSwift

struct GetPokemonPageUseCase {
    let repo: PokemonRepository
    func execute(limit: Int, page: Int) -> Single<[PokemonListItem]> { repo.fetchPage(limit: limit, page: page) }
}
