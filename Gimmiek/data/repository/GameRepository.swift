//
//  GameRepository.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 21/10/21.
//

import Foundation
import Combine
import Cleanse

protocol GameRepositoryProtocol {

    func loadMore(page:Int, keyword: String) -> Future<Game, Error>
    func deleteFavorites(_ gameUiModel: GameUiModel) -> Future<Any?, Error>
    func addFavorites(_ gameUiModel: GameUiModel) -> Future<Any?, Error>
    func checkFavorites(_ gameUiModel: GameUiModel) -> Future<Bool, Error>
    func getAllFavorites()  -> Future<[GameUiModel], Error>
}

final class GameRepository : GameRepositoryProtocol {

    let networker: NetworkerProtocol
    
    let gameDataProvider: GameDataProvider
    
    init(networker: NetworkerProtocol, gameDataProvider: GameDataProvider) {
        self.networker = networker
        self.gameDataProvider = gameDataProvider
    }
    
    func loadMore(page: Int, keyword: String) -> Future<Game, Error> {
        let endpoint = Endpoint.game(page: page, keyword: keyword)
        return networker.get(type: Game.self,
                             url: endpoint.url,
                             headers: endpoint.headers)
    }
    
    func deleteFavorites(_ gameUiModel: GameUiModel) -> Future<Any?, Error> {
        return gameDataProvider.deleteFavorites(gameUiModel)
    }
    
    func addFavorites(_ gameUiModel: GameUiModel) -> Future<Any?, Error> {
        return gameDataProvider.addFavorites(gameUiModel)
    }
    
    func checkFavorites(_ gameUiModel: GameUiModel) -> Future<Bool, Error> {
        return gameDataProvider.checkFavorites(gameUiModel)
    }
    
    func getAllFavorites() -> Future<[GameUiModel], Error> {
        return gameDataProvider.getAllFavorites()
    }
    
}

extension GameRepository {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bind(GameRepositoryProtocol.self).to(factory: GameRepository.init)
        }
    }
}
