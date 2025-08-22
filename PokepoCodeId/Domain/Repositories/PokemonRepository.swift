//
//  PokemonRepository.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import RxSwift

protocol PokemonRepository {
    func fetchPage(limit: Int, page: Int) -> Single<[PokemonListItem]>
    func fetchDetail(name: String) -> Single<PokemonDetail>
    func searchByName(_ name: String) -> Single<PokemonDetail> // direct ke detail
}
