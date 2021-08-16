//
//  UrlImage.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 16/08/21.
//

import SwiftUI

struct UrlImage: View {
    @ObservedObject var imageLoader : ImageLoader
    var emptyUrl : Bool
    
    init(urlString: String?) {
        emptyUrl = urlString == nil
        imageLoader = ImageLoader(urlString: urlString)
    }
    
    var body: some View {
        if let image = imageLoader.image  {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
        } else {
            if emptyUrl {
                Image("image_not_found")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            }else{
                EmptyStateView(isLoading: true, showEmptyState: false)
            }
            
        }
    }
}