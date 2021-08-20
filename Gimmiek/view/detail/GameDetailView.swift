//
//  GameDetail.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 15/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameDetailView: View {
    
    var game : GameUiModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            WebImage(url: URL(string: game.backgroundImage))
                .resizable()
                .placeholder(Image("image_not_found"))
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .frame(width: .infinity, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            VStack {
                VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                        Text("Rating : ")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        
                        Text("\(String(format: "%.1f", game.rating)) / \(game.ratingTop)")
                            .font(.title2)
                        
                    }.padding(.all, 10)
                    
                    HStack(alignment: .center){
                        Text("Released : ")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        
                        Text("\(game.released)")
                            .font(.title2)
                        
                    }.padding(.all, 10)
                    
                    HStack(alignment: .center) {
                        Text("Updated : ")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        
                        Text("\(game.updated)")
                            .font(.title2)
                        
                    }.padding(.all, 10)
                    
                    HStack(alignment: .top) {
                        Text("Platforms : ")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        
                        VStack(alignment: .leading) {
                            ForEach(game.platforms, id : \.self) { platform in
                                Text("• \(platform)")
                                    .font(.title3)
                                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                            }
                        }
                    }.padding(.all, 10)
                    
                    HStack(alignment: .top) {
                        Text("Genres : ")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        
                        VStack(alignment: .leading) {
                            ForEach(game.genres, id : \.self) { genre in
                                Text("• \(genre)")
                                    .font(.title3)
                                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                            }
                        }
                    }.padding(.all, 10)
                    
                    HStack(alignment: .top) {
                        Text("Tags : ")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        
                        VStack(alignment: .leading) {
                            ForEach(game.tags, id : \.self) { tag in
                                Text("• \(tag)")
                                    .font(.title3)
                                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                            }
                        }
                    }.padding(.all, 10)
                    
                    VStack(alignment: .leading) {
                        Text("Screenshots : ")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(game.screenshots, id : \.self) { screenshot in
                                    WebImage(url: URL(string: screenshot))
                                        .resizable()
                                        .placeholder(Image("image_not_found"))
                                        .indicator(.activity)
                                        .transition(.fade(duration: 0.5))
                                        .frame(width: 150, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
                                }.padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                            }
                        }
                    }.padding(.all, 10)
                }
                .background(Blur(style: .systemUltraThinMaterial))
                .cornerRadius(10)
            }.padding(.all, 10)
        }
        .background(Image("game_bg1"))
    }
}
