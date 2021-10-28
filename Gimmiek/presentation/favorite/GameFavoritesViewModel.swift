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
    
    @Published var gamesFavorites = [GameUiModel]()
    
    private var interactor: GameFavoritesInteractorProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(interactor: GameFavoritesInteractorProtocol) {
        self.interactor = interactor
    }
    
    func load() {
        interactor.getAllFavorites()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished: break
                }
            } receiveValue: { result in
                self.gamesFavorites = result
            }.store(in: &cancellables)
    }
    
    func deleteFavorites(gameId: Int?) {
        interactor.deleteFavorites(gameId)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished: break
                }
            } receiveValue: { _ in
                self.load()
            }.store(in: &cancellables)
    }
}

extension GameFavoritesViewModel {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bind(GameFavoritesViewModel.self).to(factory: GameFavoritesViewModel.init)
        }
    }
}
