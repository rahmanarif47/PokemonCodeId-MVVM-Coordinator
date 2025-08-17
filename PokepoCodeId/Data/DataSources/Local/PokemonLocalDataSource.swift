//
//  PokemonLocalDataSource.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import RxSwift

final class PokemonLocalDataSource {
    func savePage(items: [PokemonListItem], page: Int) {
        let r = RealmManager.realm
        RealmManager.write {
            for it in items {
                let rm = RMPokemonListItem()
                rm.name = it.name
                rm.page = page
                r.add(rm, update: .modified)
            }
        }
    }
    func loadPage(page: Int, limit: Int) -> [PokemonListItem] {
        let r = RealmManager.realm
        let objs = r.objects(RMPokemonListItem.self).filter("page == %@", page).prefix(limit)
        return objs.map { PokemonListItem(name: $0.name) }
    }

    func saveDetail(_ detail: PokemonDetail) {
        let r = RealmManager.realm
        RealmManager.write {
            let rm = RMPokemonDetail()
            rm.name = detail.name
            rm.abilities.removeAll()
            rm.abilities.append(objectsIn: detail.abilities)
            r.add(rm, update: .modified)
        }
    }
    func loadDetail(name: String) -> PokemonDetail? {
        let r = RealmManager.realm
        guard let rm = r.object(ofType: RMPokemonDetail.self, forPrimaryKey: name.lowercased()) else { return nil }
        return PokemonDetail(name: rm.name, abilities: Array(rm.abilities))
    }
}
