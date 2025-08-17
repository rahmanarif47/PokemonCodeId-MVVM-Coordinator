//
//  ProfileViewController.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

// Presentation/Profile/ProfileViewController.swift
import UIKit

final class ProfileViewController: UIViewController {
    private let user: User
    init(user: User) { self.user = user; super.init(nibName: nil, bundle: nil) }
    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Profile"

        let name = UILabel(); name.font = .systemFont(ofSize: 20, weight: .semibold)
        name.text = "Username: \(user.username)"
        view.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            name.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16),
        ])
    }
}
