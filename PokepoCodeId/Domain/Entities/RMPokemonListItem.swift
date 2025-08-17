//
//  RMPokemonListItem.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import RealmSwift

class RMPokemonListItem: Object {
    @Persisted(primaryKey: true) var name: String = ""
    @Persisted var page: Int = 0 // untuk pagination cache
}
