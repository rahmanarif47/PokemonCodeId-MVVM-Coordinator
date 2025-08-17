//
//  RMUser.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import RealmSwift

class RMUser: Object {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var username: String = ""
    @Persisted var passwordHash: String = ""
}
