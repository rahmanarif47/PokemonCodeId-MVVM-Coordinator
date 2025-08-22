//
//  AppCoodinator.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private let di = DIContainer()

    init(window: UIWindow) { self.window = window }

    func start() {
        let nav = UINavigationController()
        window.rootViewController = nav
        window.makeKeyAndVisible()
        showAuth(on: nav)
    }

    private func showAuth(on nav: UINavigationController) {
        let vc = LoginViewController(viewModel: .init(loginUC: di.loginUC))
        vc.onLoginSuccess = { [weak self, weak nav] user in
            self?.showMainTabs(on: nav!, user: user)
        }
        vc.onGotoRegister = { [weak self, weak nav] in
            let reg = RegisterViewController(viewModel: .init(registerUC: self!.di.registerUC))
            reg.onRegisterSuccess = { [weak self, weak nav] user in
                self?.showMainTabs(on: nav!, user: user)
            }
            nav?.pushViewController(reg, animated: true)
        }
        nav.viewControllers = [vc]
    }

    private func showMainTabs(on nav: UINavigationController, user: User) {
        let tabs = MainTabBarController(di: di, user: user)
        nav.setViewControllers([tabs], animated: true)
    }
}
