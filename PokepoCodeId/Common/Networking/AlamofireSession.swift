//
//  AlamofireSession.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import Alamofire
import RxSwift
import Foundation

final class AFSession {
    static let shared = AFSession()
    private init() {}

    func get<T: Decodable>(_ type: T.Type, url: URL, params: [String: Any]? = nil) -> Single<T> {
        return Single.create { single in
            AF.request(url, parameters: params)
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let value):
                        single(.success(value))
                    case .failure(let error):
                        single(.failure(error))
                    }
                }
            return Disposables.create()
        }
    }
}
