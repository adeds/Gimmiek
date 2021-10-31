//
//  GameMapperTest.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 31/10/21.
//

import XCTest

class GameMapperTest: XCTestCase {

    func testExample() {
        let game = GameFactory.createGame()
        let gameUiModel = GameMapper.mapToUiModel(input: game)
        
        XCTAssertEqual(game.results.count, gameUiModel.count)
    }
}
