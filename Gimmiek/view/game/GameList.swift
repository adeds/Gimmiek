//
//  GameList.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 14/08/21.
//

import SwiftUI

struct GameList: View {
    @ObservedObject var games = GameUseCase()
    
    var body: some View {
        List(games) { (game: GameUiModel) in
            GameItemView(game: game)
                .onAppear {
                    print(game)
            }
        }
    }
}
