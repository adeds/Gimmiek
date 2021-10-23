//
//  ContentView.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 14/08/21.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        let repository : GameRepositoryProtocol = GameRepository()
        GameListView(repository: repository)
    }
}
