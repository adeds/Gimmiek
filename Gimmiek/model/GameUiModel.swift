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
    
    init(name:String, released: String, backgroundImage: String?) {
        self.name = name
        self.released = released
        self.backgroundImage = backgroundImage
    }
}
