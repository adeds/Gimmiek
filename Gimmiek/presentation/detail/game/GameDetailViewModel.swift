//
//  GameDetailViewModel.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 24/10/21.
//

import Foundation
import Cleanse
import Combine
import Core

class GameDetailViewModel: ObservableObject {
    
    @Published var isFavorite: Bool = false
    
    private var interactor: GameDetailInteractorProtocol
    private var cancellables = Set<AnyCancellable>()
    var game: GameUiModel?
    
    init(interactor: GameDetailInteractorProtocol) {
        self.interactor = interactor
    }
    
    func load(game: GameUiModel) {
        self.game = game
        checkFavorite()
    }
    
    private func checkFavorite() {
        interactor.checkFavorites(game?.gameId ?? 0)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished: break
                }
            } receiveValue: { result in
                self.isFavorite = result
            }.store(in: &cancellables)
    }
    
    func changeFavorite() {
        interactor.changeFavorites(game)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished: break
                }
            } receiveValue: { result in
                self.isFavorite = result
            }.store(in: &cancellables)
    }
    
}

extension GameDetailViewModel {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bind(GameDetailViewModel.self).to(factory: GameDetailViewModel.init)
        }
    }
}
