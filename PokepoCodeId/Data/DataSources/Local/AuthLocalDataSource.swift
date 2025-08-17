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
        return Single.create { single in
            if self.userExists(username: username) {
                single(.failure(NSError(
                    domain: "Auth",
                    code: 409,
                    userInfo: [NSLocalizedDescriptionKey: "Username already exists"]
                )))
                return Disposables.create()
            }
            
            let user = User(username: username, password: password)
            self.saveUser(user)
            
            single(.success(user))
            return Disposables.create()
        }
    }

    func login(username: String, password: String) -> Single<User> {
        Single.create { single in
            let realm = RealmManager.realm
            let hash = Self.hash(password)
            if let rm = realm.objects(RMUser.self)
                .filter("username == %@ AND passwordHash == %@", username, hash)
                .first {
                
                single(.success(User(id: rm.id, username: rm.username, passwordHash: rm.passwordHash)))
            } else {
                single(.failure(NSError(
                    domain: "Auth",
                    code: 401,
                    userInfo: [NSLocalizedDescriptionKey: "Invalid credentials"]
                )))
            }
            return Disposables.create()
        }
    }
    
    // MARK: - Helpers
    private func userExists(username: String) -> Bool {
        let realm = RealmManager.realm
        return realm.objects(RMUser.self)
            .filter("username == %@", username)
            .first != nil
    }
    
    private func saveUser(_ user: User) {
        let rmUser = RMUser()
        rmUser.id = user.id
        rmUser.username = user.username
        rmUser.passwordHash = user.passwordHash
        
        let realm = RealmManager.realm
        try! realm.write {
            realm.add(rmUser, update: .modified)
        }
    }

    static func hash(_ s: String) -> String {
        let data = Data(s.utf8)
        let digest = SHA256.hash(data: data)
        return digest.map { String(format: "%02x", $0) }.joined()
    }
}
