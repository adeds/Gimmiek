//
//  ContentView.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 14/08/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var games = GameUseCase()
    
    var body: some View {
        GameListView(games: games)
    }
}
