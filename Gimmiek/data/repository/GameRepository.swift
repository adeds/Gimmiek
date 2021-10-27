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
    func changeFavorites(_ gameUiModel: GameUiModel, completion: @escaping() -> Void)
    func deleteFavorites(_ gameUiModel: GameUiModel, completion: @escaping() -> Void)
    func checkFavorites(_ gameUiModel: GameUiModel, completion: @escaping(_ isFavorite: Bool) -> Void)
    func getAllFavorites(completion: @escaping(_ listFavorites: [GameUiModel]) -> Void)
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
    
    func changeFavorites(_ gameUiModel: GameUiModel, completion: @escaping () -> Void) {
        gameDataProvider.changeFavorites(gameUiModel, completion: completion)
    }
    
    func deleteFavorites(_ gameUiModel: GameUiModel, completion: @escaping () -> Void) {
        gameDataProvider.deleteFavorites(gameUiModel, completion: completion)
    }
    
    func checkFavorites(_ gameUiModel: GameUiModel, completion: @escaping (Bool) -> Void) {
        gameDataProvider.checkFavorites(gameUiModel, completion: completion)
    }
    
    func getAllFavorites(completion: @escaping ([GameUiModel]) -> Void) {
        gameDataProvider.getAllFavorites(completion: completion)
    }
    
}

extension GameRepository {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bind(GameRepositoryProtocol.self).to(factory: GameRepository.init)
        }
    }
}
