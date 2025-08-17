//
//  TabsPagerController.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import UIKit
import XLPagerTabStrip

final class TabsPagerController: ButtonBarPagerTabStripViewController {
    private let di: DIContainer
    private let user: User

    init(di: DIContainer, user: User) {
        self.di = di; self.user = user
        super.init(nibName: nil, bundle: nil)
        title = "Pokedex"
    }
    required init?(coder: NSCoder) { fatalError() }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let home = HomeViewController(viewModel: .init(getPageUC: di.getPageUC, searchUC: di.searchUC))
        home.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        home.navigationItem.largeTitleDisplayMode = .always

        let profile = ProfileViewController(user: user)
        profile.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 1)

        return [home, profile]
    }

    override func viewDidLoad() {
        settings.style.buttonBarItemTitleColor = .label
        settings.style.selectedBarHeight = 3
        super.viewDidLoad()
    }

    func configure(cell: ButtonBarViewCell, for indicatorInfo: IndicatorInfo) {
        cell.label.text = indicatorInfo.title
    }
}
