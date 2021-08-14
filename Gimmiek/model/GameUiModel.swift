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
    
    init(name:String, released: String) {
        self.name = name
        self.released = released
    }
}
