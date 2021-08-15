//
//  Constant.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 14/08/21.
//

import Foundation

struct Constant{
    static let rawrgApiKey = "your apikey"
    static var rawgBaseUrl = "https://api.rawg.io/api/"
    
    struct Path {
        static let games = "games?"
    }
    struct QueryName {
        static let key = "&key="
        static let page = "&page="
        static let search = "&search="
    }
}
