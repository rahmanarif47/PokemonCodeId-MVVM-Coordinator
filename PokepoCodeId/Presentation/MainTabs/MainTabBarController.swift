//
//  MainTabBarController.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import UIKit

final class MainTabBarController: UITabBarController {
    private let di: DIContainer
    private let user: User

    init(di: DIContainer, user: User) {
        self.di = di; self.user = user
        super.init(nibName: nil, bundle: nil)
        setupTabs()
    }
    required init?(coder: NSCoder) { fatalError() }

    private func setupTabs() {
        let homeVC = HomeViewController(
            viewModel: .init(getPageUC: di.getPageUC, searchUC: di.searchUC)
        )
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)

        let profileVC = ProfileViewController(user: user)
        let profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 1)

        viewControllers = [homeNav, profileNav]
    }
}
