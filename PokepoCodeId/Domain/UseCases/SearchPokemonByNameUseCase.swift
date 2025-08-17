//
//  SearchPokemonByNameUseCase.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import RxSwift

struct SearchPokemonByNameUseCase {
    let repo: PokemonRepository
    func execute(name: String) -> Single<PokemonDetail> { repo.searchByName(name) }
}
