//
//  GamesResponse.swift
//  Game Hub
//
//  Created by Julsapargi Nursam on 16/02/23.
//

import Foundation

struct GamesResponse: Codable {
    
    let games: [GameResponse]
    
    enum CodingKeys: String, CodingKey {
        case games = "results"
    }
}


struct GameResponse: Hashable ,Codable, Identifiable {
    let id: Int?
    let name: String?
    let released: String?
    let image: String?
    let rating: Double?
    let playtime: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case image = "background_image"
        case rating
        case playtime
    }
}
