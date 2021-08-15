//
//  GameDetail.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 15/08/21.
//

import SwiftUI

struct GameDetailView: View {
    var game : GameUiModel
    var body: some View {
        ScrollView{
            VStack{
                Image("game_bg1")
                    .resizable()
                    .aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                Text(game.released)
            }
        }
    }
}
