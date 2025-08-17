//
//  AlamofireSession.swift
//  PokepoCodeId
//
//  Created by Arif Rahman Mac Mini on 18/08/25.
//

import Alamofire
import RxSwift

final class AFSession {
    static let shared = AFSession()
    private let session: Session = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 20
        return Session(configuration: config)
    }()

    func get<T: Decodable>(_ url: URL, params: [String: Any]? = nil) -> Single<T> {
        Single.create { single in
            let request = self.session.request(url, method: .get, parameters: params)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: T.self) { resp in
                    switch resp.result {
                    case .success(let value): single(.success(value))
                    case .failure(let error): single(.failure(error))
                    }
                }
            return Disposables.create { request.cancel() }
        }
    }
}
