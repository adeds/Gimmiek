//
//  GameUiModel.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 14/08/21.
//

import Foundation

class GameUiModel : Identifiable{
    var uuid = UUID()
    var name, released: String
    var backgroundImage: String?
    var rating : Double
    
    init(name:String, released: String, backgroundImage: String?, rating : Double) {
        self.name = name
        self.released = released
        self.backgroundImage = backgroundImage
        self.rating = rating
    }
}
