//
//  GameViewModel.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 23/10/21.
//

import Foundation
import Combine
import Cleanse
import Core

class GameListViewModel : ObservableObject {
    @Published var games = [GameUiModel]()
    @Published var isLoading = false
    
    private var interactor: GameInteractorProtocol
    private var cancellables = Set<AnyCancellable>()
    
    private var page = 1
    private var keyword = ""
    
    init(interactor: GameInteractorProtocol) {
        self.interactor = interactor
        self.searchGame(keyword: keyword)
    }
    
    private func fetchGameList() {
        isLoading = true
        interactor.loadMore(page: page, keyword:keyword)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.isLoading = false
                    print(error)
                case .finished: break
                }
            } receiveValue: { result in
                self.isLoading = false
                self.games = result
            }.store(in: &cancellables)
    }
    
    func searchGame(keyword: String) {
        self.keyword = keyword
        page = 1
        fetchGameList()
    }
    
    func loadMore(game: GameUiModel) {
        if isLoading || games.count < 9 {
            return
        }
        
        if games[games.count-5].gameId == game.gameId {
            page += 1
            fetchGameList()
        }
    }
}

extension GameListViewModel {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bind(GameListViewModel.self).to(factory: GameListViewModel.init)
        }
    }
}
