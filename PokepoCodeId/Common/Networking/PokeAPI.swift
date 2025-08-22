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
        let results: [ListItem]
        
        struct ListItem: Decodable {
            let name: String
            let url: String
        }
    }
    
    struct PokemonDetailResponse: Decodable {
        let name: String
        let abilities: [AbilityEntry]
        
        struct AbilityEntry: Decodable {
            let ability: Ability
            
            struct Ability: Decodable {
                let name: String
            }
        }
    }
}
