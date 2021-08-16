//
//  GameItemView.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 14/08/21.
//

import SwiftUI

struct GameItemView: View {
    var game: GameUiModel
    
    var body: some View {
        VStack(alignment: .leading) {
            UrlImage(urlString: game.backgroundImage)
            Text("\(game.name)")
                .font(.headline)
            Text("\(game.released)")
                .font(.subheadline)
        }
    }
}
