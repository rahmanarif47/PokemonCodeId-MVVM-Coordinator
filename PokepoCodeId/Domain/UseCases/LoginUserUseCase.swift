//
//  LoginUserUseCase.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import RxSwift

struct LoginUserUseCase {
    let repo: AuthRepository
    func execute(username: String, password: String) -> Single<User> { repo.login(username: username, password: password) }
}
