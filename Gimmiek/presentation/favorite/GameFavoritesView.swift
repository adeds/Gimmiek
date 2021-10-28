//
//  GameFavoritesView.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 24/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameFavoritesView: View {
    let router: RouterProtocol
    @ObservedObject var viewModel: GameFavoritesViewModel
    
    var body: some View {
        ZStack {
            List {
                ForEach(viewModel.gamesFavorites, id: \.gameId) { (game: GameUiModel) in
                    NavigationLink(
                        destination: router.toGameDetail(game: game)
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
                .onDelete(perform: { indexSet in
                    withAnimation {
                        indexSet.forEach { index in
                            viewModel.deleteFavorites(gameId: viewModel.gamesFavorites[index].gameId)
                        }
                    }
                })
                .listRowBackground(SwiftUI.Color.clear)
            }
            
            VStack {
                EmptyStateView(isLoading: false, showEmptyState: viewModel.gamesFavorites.isEmpty)
                    .frame(
                        minWidth: 100, idealWidth: 300, maxWidth: 400,
                        minHeight: 100, idealHeight: 300, maxHeight: 400,
                        alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
        }
        .onAppear {
            viewModel.load()
        }.background(Image("game_bg")
                        .resizable()
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/))
    }
}
