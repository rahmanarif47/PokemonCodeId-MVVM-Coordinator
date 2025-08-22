//
//  RMPokemonDetail.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import RealmSwift

class RMPokemonDetail: Object {
    @Persisted(primaryKey: true) var name: String = ""
    @Persisted var abilities = List<String>()
}
