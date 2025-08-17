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
    }
    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        let pager = TabsPagerController(di: di, user: user)
        pager.tabBarItem = UITabBarItem(title: "Pages", image: UIImage(systemName: "square.grid.2x2"), selectedImage: nil)
        viewControllers = [UINavigationController(rootViewController: pager)]
    }
}
