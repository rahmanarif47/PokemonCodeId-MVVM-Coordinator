//
//  Untitled.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import RxSwift
import CryptoKit

final class AuthLocalDataSource {
    func register(username: String, password: String) -> Single<User> {
        Single.create { single in
            let realm = RealmManager.realm
            if realm.objects(RMUser.self).filter("username == %@", username).first != nil {
                return single(.failure(NSError(domain: "Auth", code: 409, userInfo: [NSLocalizedDescriptionKey: "Username already exists"])))
            }
            let rm = RMUser()
            rm.username = username
            rm.passwordHash = Self.hash(password)
            RealmManager.write { realm.add(rm, update: .modified) }
            single(.success(User(id: rm.id, username: rm.username, passwordHash: rm.passwordHash)))
            return Disposables.create()
        }
    }

    func login(username: String, password: String) -> Single<User> {
        Single.create { single in
            let realm = RealmManager.realm
            let hash = Self.hash(password)
            if let rm = realm.objects(RMUser.self).filter("username == %@ AND passwordHash == %@", username, hash).first {
                single(.success(User(id: rm.id, username: rm.username, passwordHash: rm.passwordHash)))
            } else {
                single(.failure(NSError(domain: "Auth", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid credentials"])))
            }
            return Disposables.create()
        }
    }

    private static func hash(_ s: String) -> String {
        let data = Data(s.utf8)
        let digest = SHA256.hash(data: data)
        return digest.map { String(format: "%02x", $0) }.joined()
    }
}
