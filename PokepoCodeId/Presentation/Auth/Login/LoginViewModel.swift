//
//  LoginViewModel.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import RxSwift
import RxCocoa

final class LoginViewModel {
    let username = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    let isLoading = BehaviorRelay<Bool>(value: false)
    let loginTapped = PublishRelay<Void>()
    let result = PublishRelay<Result<User, Error>>()

    private let disposeBag = DisposeBag()
    private let loginUC: LoginUserUseCase

    init(loginUC: LoginUserUseCase) {
        self.loginUC = loginUC

        loginTapped.withLatestFrom(Observable.combineLatest(username.asObservable(), password.asObservable()))
            .do(onNext: { _ in self.isLoading.accept(true) })
            .flatMapLatest { (u, p) in loginUC.execute(username: u, password: p).asObservable().materialize() }
            .subscribe(onNext: { [weak self] ev in
                self?.isLoading.accept(false)
                switch ev {
                case .next(let user): self?.result.accept(.success(user))
                case .error(let err): self?.result.accept(.failure(err))
                default: break
                }
            }).disposed(by: disposeBag)
    }
}
