//
//  Networker.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 23/10/21.
//

import Foundation
import Combine
import Alamofire
import Cleanse

protocol NetworkerProtocol: AnyObject {
    typealias Headers = [String: Any]
    
    func getGame(url: URL, result: @escaping (Result<Game, AFError>) -> Void)
}

class Networker: NetworkerProtocol {
    
    func getGame(url: URL,result: @escaping (Result<Game, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseDecodable(of: Game.self) { response in
                switch response.result {
                case .success(let value): result(.success(value))
                case .failure: result(.failure(.invalidURL(url: url)))
                }
            }
    }
}

extension Networker {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bind(NetworkerProtocol.self).to {
                Networker()
            }
        }
    }
}
