//
//  GameList.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 14/08/21.
//

import SwiftUI

struct GameListView: View {
    @ObservedObject var games = GameUseCase()
    
    var body: some View {
        NavigationView {
            ZStack{
                List{
                    ForEach(games, id: \.uuid) { (game: GameUiModel) in
                        NavigationLink(destination: GameDetailView()) {
                            GameItemView(game: game)
                                .onAppear {
                                    print(game.name)
                                }
                        }
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                        .background(Blur(style: .systemUltraThinMaterial))
                        .cornerRadius(10)
                    }
                    .listRowBackground(SwiftUI.Color.clear)
                    
                }
                .onAppear(){
                    UITableViewCell.appearance().selectionStyle = .none
                    UITableView.appearance().backgroundColor = .clear
                    UITableViewCell.appearance().backgroundColor = .clear
                }
                .background(Image("game_bg1"))
                .navigationBarTitle("Gimmiek")
                VStack {
                    EmptyStateView(isLoading: games.isLoading, showEmptyState: games.isEmpty)
                }
            }
            
        }
    }
}
