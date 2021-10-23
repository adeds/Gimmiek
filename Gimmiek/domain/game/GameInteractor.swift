//
//  GameInteractor.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 21/10/21.
//

import Foundation
import Combine

protocol GameInteractorProtocol {
    
    var repository: GameRepositoryProtocol { get }
    
    func loadMore(page:Int, keyword:String) -> AnyPublisher<[GameUiModel], Error>
}

class GameInteractor: GameInteractorProtocol {
    
    let repository: GameRepositoryProtocol
    let networker: NetworkerProtocol = Networker()
    
    init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadMore(page: Int, keyword:String) -> AnyPublisher<[GameUiModel], Error> {
        let result = repository.loadMore(page: page, keyword:keyword)
        
        return result.map { game in
            game.toGameUiModel()
        }.eraseToAnyPublisher()}
}
