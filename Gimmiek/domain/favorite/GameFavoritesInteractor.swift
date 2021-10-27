//
//  GameFavoritesInteractor.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 27/10/21.
//

import Foundation
import Cleanse
import Combine

protocol GameFavoritesInteractorProtocol {
    func getAllFavorites() -> AnyPublisher<[GameUiModel], Error>
    func deleteFavorites(_ gameUiModel: GameUiModel?) -> AnyPublisher<Any?, Error>
}

class GameFavoritesInteractor : GameFavoritesInteractorProtocol {

    let repository: GameRepositoryProtocol
    
    init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    func getAllFavorites() -> AnyPublisher<[GameUiModel], Error> {
        return repository.getAllFavorites().eraseToAnyPublisher()
    }
    
    func deleteFavorites(_ gameUiModel: GameUiModel?) -> AnyPublisher<Any?, Error> {
        guard let game = gameUiModel else {
            print("game nil, load game first")
            return Just(nil).setFailureType(to: Error.self).eraseToAnyPublisher()
        }
        return repository.deleteFavorites(game).eraseToAnyPublisher()
    }
}

extension GameFavoritesInteractor {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bind(GameFavoritesInteractorProtocol.self).to(factory: GameFavoritesInteractor.init)
        }
    }
}
