//
//  AccountDetailView.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 15/08/21.
//

import SwiftUI

struct AccountDetailView: View {
    var body: some View {
        VStack{
            Text("Adetya Dyas Saputra").font(.largeTitle)
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                .background(Blur(style: .systemUltraThinMaterial))
                .cornerRadius(10)
            Image("me")
                .resizable()
                .clipShape(Circle())
                .padding(30)
                .aspectRatio(1, contentMode: .fit)
        }.background(Image("game_bg1"))
    }
}
