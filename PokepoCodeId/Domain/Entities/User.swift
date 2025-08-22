//
//  User.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import Foundation
import RealmSwift

struct User {
    let id: ObjectId
    let username: String
    let passwordHash: String
    
    init(id: ObjectId = ObjectId.generate(), username: String, password: String) {
        self.id = id
        self.username = username
        self.passwordHash = AuthLocalDataSource.hash(password)
    }
    
    init(id: ObjectId, username: String, passwordHash: String) {
        self.id = id
        self.username = username
        self.passwordHash = passwordHash
    }
}
