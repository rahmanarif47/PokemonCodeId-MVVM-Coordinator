//
//  GetPokemonDetailUseCase.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import RxSwift

struct GetPokemonDetailUseCase {
    let repo: PokemonRepository
    func execute(name: String) -> Single<PokemonDetail> { repo.fetchDetail(name: name) }
}
