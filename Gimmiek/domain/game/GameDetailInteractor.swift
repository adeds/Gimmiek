//
//  GameDetailInteractor.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 24/10/21.
//

import Foundation
import Cleanse

protocol GameDetailInteractorProtocol {
    func changeFavorites(_ gameUiModel: GameUiModel?, completion: @escaping() -> Void)
    func checkFavorites(_ gameUiModel: GameUiModel?, completion: @escaping(_ isFavorite: Bool) -> Void)
}

class GameDetailInteractor: GameDetailInteractorProtocol {
    
    let repository: GameRepositoryProtocol
    
    init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    func changeFavorites(_ gameUiModel: GameUiModel?, completion: @escaping () -> Void) {
        guard let game = gameUiModel else {
            print("game nil, load game first")
            return
        }
        repository.changeFavorites(game, completion: completion)
    }
    
    func checkFavorites(_ gameUiModel: GameUiModel?, completion: @escaping (Bool) -> Void) {
        guard let game = gameUiModel else {
            print("game nil, load game first")
            return
        }
        
        repository.checkFavorites(game, completion: completion)
    }
}

extension GameDetailInteractor {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bind(GameDetailInteractorProtocol.self).to(factory: GameDetailInteractor.init)
        }
    }
}
