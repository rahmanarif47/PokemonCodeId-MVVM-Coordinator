//
//  DIContainer.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import Foundation

final class DIContainer {
    let authRepo: AuthRepository = AuthRepositoryImpl()
    let pokemonRepo: PokemonRepository = PokemonRepositoryImpl()
    var registerUC: RegisterUserUseCase { .init(repo: authRepo) }
    var loginUC: LoginUserUseCase { .init(repo: authRepo) }
    var getPageUC: GetPokemonPageUseCase { .init(repo: pokemonRepo) }
    var getDetailUC: GetPokemonDetailUseCase { .init(repo: pokemonRepo) }
    var searchUC: SearchPokemonByNameUseCase { .init(repo: pokemonRepo) }
}
