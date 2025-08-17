//
//  AuthRepository.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import RxSwift

protocol AuthRepository {
    func register(username: String, password: String) -> Single<User>
    func login(username: String, password: String) -> Single<User>
    func currentUser() -> User?
    func logout()
}
