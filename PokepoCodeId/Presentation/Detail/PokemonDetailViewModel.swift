//
//  PokemonDetailViewModel.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import RxSwift
import RxCocoa

final class PokemonDetailViewModel {
    let name = BehaviorRelay<String>(value: "")
    let abilities = BehaviorRelay<[String]>(value: [])

    init(initialDetail: PokemonDetail) {
        name.accept(initialDetail.name.capitalized)
        abilities.accept(initialDetail.abilities.map { $0.capitalized })
    }
}
