//
//  ContentView.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 14/08/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var viewModel: GameListViewModel
    
    let router: RouterProtocol
    init(router: RouterProtocol) {
        self.router = router
    }
    
    var body: some View {
        GameListView(viewModel: viewModel, router: router)
    }
}
