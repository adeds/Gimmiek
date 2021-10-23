//
//  GameViewModel.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 23/10/21.
//

import Foundation
import Combine
import Alamofire

class GameListViewModel : ObservableObject {
    @Published var games = [GameUiModel]()
    @Published var isLoading = false
    
    private var interactor: GameInteractorProtocol
    private var cancellables = Set<AnyCancellable>()
    
    private var page = 1
    private var keyword = ""
    
    init(interactor: GameInteractorProtocol, games: [GameUiModel] = [GameUiModel]()) {
        self.games = games
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
        
        if games[games.count-5].uuid == game.uuid {
            page += 1
            fetchGameList()
        }
    }
}
