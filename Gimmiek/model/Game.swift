//
//  Game.swift
//  Gimmiek
//
//  Created by Ade Dyas  on 14/08/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let game = try? newJSONDecoder().decode(Game.self, from: jsonData)

import Foundation

// MARK: - Game
struct Game: Codable {
    let results: [Result]
    let next : String?
    
    enum CodingKeys: String, CodingKey {
        case results, next
    }
}

// MARK: - Result
struct Result: Codable {
    let id: Int?
    let name, released, backgroundImage, updated: String?
    let rating: Double?
    let ratingTop: Int?
    let platforms: [PlatformElement]?
    let genres: [Genre]?
    let tags: [Genre]?
    let shortScreenshots: [ShortScreenshot]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, released, rating, updated, platforms, genres, tags
        case ratingTop = "rating_top"
        case backgroundImage = "background_image"
        case shortScreenshots = "short_screenshots"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
}

// MARK: - PlatformElement
struct PlatformElement: Codable {
    let platform: PlatformPlatform?
    
    enum CodingKeys: String, CodingKey {
        case platform
    }
}

// MARK: - PlatformPlatform
struct PlatformPlatform: Codable {
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}

// MARK: - ShortScreenshot
struct ShortScreenshot: Codable {
    let id: Int?
    let image: String?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError
                .typeMismatch(
                    JSONNull.self,
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "Wrong type for JSONNull"
                    )
                )
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
