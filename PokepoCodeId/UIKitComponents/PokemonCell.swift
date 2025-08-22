//
//  PokemonCell.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import UIKit
import Kingfisher

final class PokemonCell: UITableViewCell {
    static let reuse = "PokemonCell"
    private let nameLabel = UILabel()
    private let iconView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        contentView.addSubview(iconView)
        contentView.addSubview(nameLabel)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        iconView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 40),
            iconView.heightAnchor.constraint(equalToConstant: 40),
            nameLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
    }
    required init?(coder: NSCoder) { fatalError() }

    func fill(_ item: PokemonListItem) {
        nameLabel.text = item.name.capitalized
        // optional image: PokeAPI sprites but kita gak wajib
        // contoh jika mau pakai gambar dari raw sprites url (tidak dijamin lengkap):
        let url = URL(string: "https://img.pokemondb.net/sprites/home/normal/\(item.name).png")
        iconView.kf.setImage(with: url, placeholder: nil)
    }
}
