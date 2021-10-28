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
    func deleteFavorites(_ gameId: Int?) -> AnyPublisher<Any?, Error>
}

class GameFavoritesInteractor : GameFavoritesInteractorProtocol {

    let repository: GameRepositoryProtocol
    
    init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    func getAllFavorites() -> AnyPublisher<[GameUiModel], Error> {
        return repository.getAllFavorites().eraseToAnyPublisher()
    }
    
    func deleteFavorites(_ gameId: Int?) -> AnyPublisher<Any?, Error> {
        return repository.deleteFavorites(gameId).eraseToAnyPublisher()
    }
}

extension GameFavoritesInteractor {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bind(GameFavoritesInteractorProtocol.self).to(factory: GameFavoritesInteractor.init)
        }
    }
}
