//
//  ImageLoader.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 16/08/21.
//

import Foundation
import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    var imageCache = ImageCache.build()
    
    init(urlString: String?) {
        loadImage(urlString)
    }
    
    func loadImage(_ urlString : String?) {
        guard let urlString = urlString else {
            return
        }
        
        if loadImageFromCache(urlString) {
            return
        }
        
        loadImageFromUrl(urlString)
    }
    
    func loadImageFromCache(_ urlString : String) -> Bool {
        guard let cacheImage = imageCache.get(forKey: urlString) else {
            return false
        }
        
        image = cacheImage
        return true
    }
    
    func loadImageFromUrl(_ urlString : String) {
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if let error = error  {
                print(error)
                DispatchQueue.main.async {
                    self.image = UIImage(named: "image_not_found")
                }
            }else if let data = data {
                DispatchQueue.main.async {
                    guard let loadedImage = UIImage(data: data) else {
                        return
                    }
                    
                    self.imageCache.set(forKey: urlString, image: loadedImage)
                    self.image = loadedImage
                }
            }
            
            
        }
        task.resume()
    }
    
    
}

class ImageCache {
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}

extension ImageCache {
    private static var imageCache = ImageCache()
    static func build() -> ImageCache {
        return imageCache
    }
}
