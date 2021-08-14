//
//  GameUseCase.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 14/08/21.
//

import Foundation

class GameUseCase: ObservableObject, RandomAccessCollection {
    typealias Element = GameUiModel
    var startIndex: Int { games.startIndex }
    var endIndex: Int { games.endIndex }
    
    subscript(position: Int) -> GameUiModel {
        return games[position]
    }
    @Published var games = [GameUiModel]()
    
    init() {
        games = [
            GameUiModel(name: "name", released: "date")
        ]
    }
}
