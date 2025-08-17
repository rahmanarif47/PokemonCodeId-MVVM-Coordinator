//
//  RealmManager.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import RealmSwift

struct RealmManager {
    static var realm: Realm = {
        var config = Realm.Configuration(schemaVersion: 1)
        Realm.Configuration.defaultConfiguration = config
        return try! Realm()
    }()

    static func write(_ block: () -> Void) {
        let r = realm
        try? r.write { block() }
    }
}
