//
//  LoginViewController.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {
    var onLoginSuccess: ((User) -> Void)?
    var onGotoRegister: (() -> Void)?

    private let vm: LoginViewModel
    private let bag = DisposeBag()

    private let usernameField = UITextField()
    private let passwordField = UITextField()
    private let loginBtn = UIButton(type: .system)
    private let registerBtn = UIButton(type: .system)

    init(viewModel: LoginViewModel) {
        self.vm = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "Login"
    }
    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()

        usernameField.rx.text.orEmpty.bind(to: vm.username).disposed(by: bag)
        passwordField.rx.text.orEmpty.bind(to: vm.password).disposed(by: bag)
        loginBtn.rx.tap.bind(to: vm.loginTapped).disposed(by: bag)
        registerBtn.rx.tap.subscribe(onNext: { [weak self] in self?.onGotoRegister?() }).disposed(by: bag)

        vm.isLoading.asDriver().drive(onNext: { [weak self] loading in
            loading ? self?.showHUD("Logging in...") : self?.hideHUD()
        }).disposed(by: bag)

        vm.result.subscribe(onNext: { [weak self] res in
            switch res {
            case .success(let user): self?.onLoginSuccess?(user)
            case .failure(let err): self?.showAlert(err.localizedDescription)
            }
        }).disposed(by: bag)
    }

    private func setupUI() {
        usernameField.placeholder = "Username"
        usernameField.borderStyle = .roundedRect
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        passwordField.borderStyle = .roundedRect
        loginBtn.setTitle("Login", for: .normal)
        registerBtn.setTitle("Register", for: .normal)

        let stack = UIStackView(arrangedSubviews: [usernameField, passwordField, loginBtn, registerBtn])
        stack.axis = .vertical; stack.spacing = 12
        view.addSubview(stack); stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])
    }
}
