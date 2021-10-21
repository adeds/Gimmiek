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
        VStack {
            Text(account.name)
                .font(.largeTitle)
                .padding(.all, 5)
                .background(Blur(style: .systemUltraThinMaterial))
                .cornerRadius(10)
                .padding(.top, 30)
            
            Image("me")
                .resizable()
                .clipShape(Circle())
                .padding(30)
                .aspectRatio(1, contentMode: .fit)
            
            TextField("Change Name",
                      text: $input,
                      onEditingChanged: {_ in },
                      onCommit: {
                        account.name = input
                      })
                .keyboardType(.webSearch)
                .padding(.all, 10)
                .background(Blur(style: .systemUltraThinMaterial))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 1)
                )
                .padding(.horizontal, 20)
            
            Spacer()
            
            Button(action: {
                
            }, label: {
                NavigationLink(destination: GameFavoritesView()
                                .navigationBarTitle("Favorites")) {
                    Text("My Favorites")
                        .frame(
                            minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,
                            idealWidth: .infinity,
                            maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                            minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,
                            idealHeight: 40,
                            maxHeight: 40,
                            alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/
                        )
                }
            })
            .background(Blur())
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white, lineWidth: 1)
            )
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
            
        }.background(Image("game_bg")
                        .resizable()
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/))
    }
}
