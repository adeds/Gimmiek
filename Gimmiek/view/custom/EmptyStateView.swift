//
//  EmptyStateView.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 15/08/21.
//

import SwiftUI

struct EmptyStateView: View {
    var isLoading = false
    var showEmptyState = false
    var body: some View {
        if isLoading || showEmptyState {
            HStack {
                Spacer()
                VStack {
                    if isLoading {
                        ProgressView("Loading")
                            .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    } else if showEmptyState {
                        Image("empty_icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .background(Blur())
                .cornerRadius(10)
                Spacer()
            }
        }
        
    }
}
