//
//  RegisterViewModel.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import RxSwift
import RxCocoa

final class RegisterViewModel {
    let username = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    let registerTapped = PublishRelay<Void>()
    let isLoading = BehaviorRelay<Bool>(value: false)
    let result = PublishRelay<Result<User, Error>>()

    private let bag = DisposeBag()
    private let registerUC: RegisterUserUseCase

    init(registerUC: RegisterUserUseCase) {
        self.registerUC = registerUC
        registerTapped.withLatestFrom(Observable.combineLatest(username.asObservable(), password.asObservable()))
            .do(onNext: { _ in self.isLoading.accept(true) })
            .flatMapLatest { (u,p) in registerUC.execute(username: u, password: p).asObservable().materialize() }
            .subscribe(onNext: { [weak self] ev in
                self?.isLoading.accept(false)
                switch ev {
                case .next(let user): self?.result.accept(.success(user))
                case .error(let err): self?.result.accept(.failure(err))
                default: break
                }
            }).disposed(by: bag)
    }
}
