//
//  AccountDetailView.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 15/08/21.
//

import SwiftUI

struct AccountDetailView: View {
    @ObservedObject var account = AccountUseCase()

    @State var input: String = ""
    
    var body: some View {
        VStack{
            Text(account.name)
                .font(.largeTitle)
                .padding(.all, 5)
                .background(Blur(style: .systemUltraThinMaterial))
                .cornerRadius(10)
            Image("me")
                .resizable()
                .clipShape(Circle())
                .padding(30)
                .aspectRatio(1, contentMode: .fit)
            TextField("Ubah Nama",
                      text: $input,
                      onEditingChanged: {_ in },
                      onCommit: {
                        account.name = input
                      })
                .keyboardType(.webSearch)
                .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))
                .background(Blur(style: .systemUltraThinMaterial))
                .cornerRadius(10)
                .padding(.horizontal, 20)
        }.background(Image("game_bg1"))
    }
}
