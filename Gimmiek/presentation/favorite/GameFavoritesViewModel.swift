//
//  GameFavoritesViewModel.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 27/10/21.
//

import Foundation
import Combine
import Cleanse

class GameFavoritesViewModel: ObservableObject {
    
    @Published var gamesFavorites: [GameUiModel] = [GameUiModel]()
    
    private var interactor: GameFavoritesInteractorProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(interactor: GameFavoritesInteractorProtocol) {
        self.interactor = interactor
    }
    
    func load() {
        interactor.getAllFavorites { listFavorites in
            self.gamesFavorites.removeAll()
            self.gamesFavorites.append(contentsOf: listFavorites)
        }
    }
    
    func deleteFavorites(game:GameUiModel) {
        interactor.deleteFavorites(game) {
            self.load()
        }
    }
}

extension GameFavoritesViewModel {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bind(GameFavoritesViewModel.self).to(factory: GameFavoritesViewModel.init)
        }
    }
}

