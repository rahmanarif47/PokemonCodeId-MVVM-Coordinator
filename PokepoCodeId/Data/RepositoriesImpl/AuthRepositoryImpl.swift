//
//  AuthRepositoryImpl.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import RxSwift

final class AuthRepositoryImpl: AuthRepository {
    private let local = AuthLocalDataSource()
    private var _currentUser: User?

    func register(username: String, password: String) -> Single<User> {
        local.register(username: username, password: password).do(onSuccess: { self._currentUser = $0 })
    }
    func login(username: String, password: String) -> Single<User> {
        local.login(username: username, password: password).do(onSuccess: { self._currentUser = $0 })
    }
    func currentUser() -> User? { _currentUser }
    func logout() { _currentUser = nil }
}
