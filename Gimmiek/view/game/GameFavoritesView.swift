//
//  GameFavoritesView.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 24/08/21.
//

import SwiftUI

struct GameFavoritesView: View {
    var provider: GameDataProvider = { return GameDataProvider() }()

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear(){
                provider.getAllFavorites(){ list in
                    debugPrint(list)
                }
            }
    }
}
