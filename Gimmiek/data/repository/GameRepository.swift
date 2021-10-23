//
//  GameRepository.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 21/10/21.
//

import Foundation
import Combine

protocol GameRepositoryProtocol {

    var networker: NetworkerProtocol { get }

    func loadMore(page:Int, keyword: String) -> Future<Game, Error>
}

final class GameRepository : GameRepositoryProtocol {
    
    let networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol = Networker()) {
        self.networker = networker
    }
    
    func loadMore(page: Int, keyword: String) -> Future<Game, Error> {
        let endpoint = Endpoint.game(page: page, keyword: keyword)
        return networker.get(type: Game.self,
                             url: endpoint.url,
                             headers: endpoint.headers)
    }
}
