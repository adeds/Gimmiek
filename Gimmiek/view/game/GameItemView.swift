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
        HStack(alignment: .bottom) {
            VStack(alignment: .leading){
                Text("\(game.name)")
                    .font(.headline)
                Text("\(game.released)")
                    .font(.subheadline)
            }
            Spacer()
            Text("⭐️\(String(format: "%.1f", game.rating))")
                .font(.headline)
        }
        .padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 10))
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .background(Blur(style: .systemUltraThinMaterial))
    }
}
