//
//  RandomFactory.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 31/10/21.
//

import Foundation

final class RandomFactory {
    static func randomString() -> String {
        return NSUUID().uuidString
    }
    
    static func randomInt() -> Int {
        return Int.random(in: 1..<100)
    }
    
    static func randomDouble() -> Double {
        return Double(randomInt())
    }
}
