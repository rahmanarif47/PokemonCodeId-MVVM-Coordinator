//
//  PokeAPI.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import Foundation

enum PokeAPI {
    static let base = URL(string: "https://pokeapi.co/api/v2")!

    struct ListResponse: Decodable {
        let count: Int
        let next: String?
        let previous: String?
        let results: [Item]
        struct Item: Decodable { let name: String; let url: String }
    }

    struct PokemonDetailResponse: Decodable {
        let name: String
        let abilities: [AbilityWrap]
        struct AbilityWrap: Decodable {
            let ability: Ability
            struct Ability: Decodable { let name: String }
        }
    }
}
