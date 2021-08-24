//
//  GameFavoritesView.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 24/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameFavoritesView: View {
    @State var games = [GameUiModel]()
    var provider: GameDataProvider = { return GameDataProvider() }()
    

    var body: some View {
        List {
            ForEach(games, id: \.uuid) { (game: GameUiModel) in
                NavigationLink(
                    destination: GameDetailView(game: game)
                        .navigationBarTitle(game.name)) {
                    GameItemView(game: game)
                }
                .padding(EdgeInsets(top: 150, leading: 0, bottom: 0, trailing: 0))
                .background(
                    WebImage(url: URL(string: game.backgroundImage))
                        .resizable()
                        .placeholder(Image("image_not_found"))
                        .indicator(.activity)
                        .transition(.fade(duration: 0.5))
                )
                .cornerRadius(10)
                
            }
            .listRowBackground(SwiftUI.Color.clear)
        }.onAppear(){
            provider.getAllFavorites(){ list in
                games.removeAll()
                games.append(contentsOf: list)
            }
        }
            
    }
}
