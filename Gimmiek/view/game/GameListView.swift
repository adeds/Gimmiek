//
//  GameList.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 14/08/21.
//

import SwiftUI

struct GameListView: View {
    @ObservedObject var games: GameUseCase

    @State var input: String = ""
    
    var body: some View {
        NavigationView {
            ZStack{
                List{
                    HStack{
                        ZStack{
                            Image(systemName: "person")
                                .padding(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                .background(Blur(style: .systemUltraThinMaterial))
                                .cornerRadius(10)
                            
                            NavigationLink(destination: AccountDetailView().navigationBarTitle("Account")){
                                EmptyView()
                            }
                        }.aspectRatio(contentMode: .fit)
                        TextField("Search", text: $input, onEditingChanged: {_ in
                            
                        }, onCommit: {
                            self.games.searchGame(keyword: input)
                        })
                        .keyboardType(.webSearch)
                        .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))
                        .background(Blur(style: .systemUltraThinMaterial))
                        .cornerRadius(10)
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    }.listRowBackground(SwiftUI.Color.clear)
                    
                    ForEach(games.games, id: \.uuid) { (game: GameUiModel) in
                        NavigationLink(destination: GameDetailView(game: game).navigationBarTitle(game.name)) {
                            GameItemView(game: game)
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
                    EmptyStateView(isLoading: games.isLoading, showEmptyState: games.games.isEmpty)
                        .frame(minWidth: 100, idealWidth: 300, maxWidth: 400, minHeight: 100, idealHeight: 300, maxHeight: 400, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
            }
            
        }
    }
}
