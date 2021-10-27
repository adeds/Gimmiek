//
//  GameDetailInteractor.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 24/10/21.
//

import Foundation
import Cleanse
import Combine

protocol GameDetailInteractorProtocol {
    func changeFavorites(_ gameUiModel: GameUiModel?) -> AnyPublisher<Bool, Error>
    func checkFavorites(_ gameUiModel: GameUiModel?) -> AnyPublisher<Bool, Error>
}

class GameDetailInteractor: GameDetailInteractorProtocol {
    
    let repository: GameRepositoryProtocol
    
    init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    func changeFavorites(_ gameUiModel: GameUiModel?) -> AnyPublisher<Bool, Error> {
        guard let game = gameUiModel else {
            print("game nil, load game first")
            return Empty().eraseToAnyPublisher()
        }
        return repository.checkFavorites(game).map { isFavorite in
            if isFavorite {
                self.repository.deleteFavorites(game)
            } else {
                self.repository.addFavorites(game)
            }
            
            return !isFavorite
        }.eraseToAnyPublisher()
    }
    
    func checkFavorites(_ gameUiModel: GameUiModel?) -> AnyPublisher<Bool, Error> {
        guard let game = gameUiModel else {
            print("game nil, load game first")
            return Empty().eraseToAnyPublisher()
        }
        return repository.checkFavorites(game).eraseToAnyPublisher()
    }
}

extension GameDetailInteractor {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bind(GameDetailInteractorProtocol.self).to(factory: GameDetailInteractor.init)
        }
    }
}
