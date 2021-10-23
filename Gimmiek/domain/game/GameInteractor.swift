//
//  GameInteractor.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 21/10/21.
//

import Foundation
import Combine
import Cleanse

protocol GameInteractorProtocol {
    func loadMore(page:Int, keyword:String) -> AnyPublisher<[GameUiModel], Error>
}

class GameInteractor: GameInteractorProtocol {
    
    let repository: GameRepositoryProtocol
    let networker: NetworkerProtocol = Networker()
    
    private var isLastPage = false
    private var keyword = ""
    private var prevList : [GameUiModel] = [GameUiModel]()
    
    init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadMore(page: Int, keyword:String) -> AnyPublisher<[GameUiModel], Error> {
        let result = repository.loadMore(page: page, keyword:keyword)
        if isLastPage {
            let noFetch = Just(prevList)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
            return noFetch
        }
        return result.map { game in
            let gameUiModel = game.toGameUiModel()
            let isNewKeyword = self.keyword != keyword
            self.isLastPage = gameUiModel.isEmpty && !isNewKeyword
            self.keyword = keyword
            if isNewKeyword {
                self.prevList.removeAll()
            }
            self.prevList.append(contentsOf: gameUiModel)
            return self.prevList
        }.eraseToAnyPublisher()}
}

extension GameInteractor {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Unscoped>) {
            binder.bind(GameInteractorProtocol.self).to(factory: GameInteractor.init)
        }
    }
}
