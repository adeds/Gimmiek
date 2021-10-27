//
//  GameFavoritesInteractor.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 27/10/21.
//

import Foundation
import Cleanse

protocol GameFavoritesInteractorProtocol {
    func getAllFavorites(completion: @escaping(_ listFavorites: [GameUiModel]) -> Void)
    func deleteFavorites(_ gameUiModel: GameUiModel?, completion: @escaping() -> Void)
}

class GameFavoritesInteractor : GameFavoritesInteractorProtocol {
    
    let repository: GameRepositoryProtocol
    
    init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    func getAllFavorites(completion: @escaping ([GameUiModel]) -> Void) {
        return repository.getAllFavorites(completion: completion)
    }
    
    func deleteFavorites(_ gameUiModel: GameUiModel?, completion: @escaping () -> Void) {
        guard let game = gameUiModel else {
            print("game nil, load game first")
            return
        }
        repository.deleteFavorites(game, completion: completion)
    }
}

extension GameFavoritesInteractor {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bind(GameFavoritesInteractorProtocol.self).to(factory: GameFavoritesInteractor.init)
        }
    }
}
