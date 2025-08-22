//
//  RMUser.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import RealmSwift

final class RMUser: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var username: String = ""
    @Persisted var passwordHash: String = ""
}
