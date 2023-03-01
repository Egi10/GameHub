//
//  DetailGameResponse.swift
//  Game Hub
//
//  Created by Julsapargi Nursam on 19/02/23.
//

import Foundation

struct DetailGameResponse: Codable {
    let id: Int
    let name, description, descriptionRaw: String
    let released: String
    let backgroundImage: String
    let rating: Double
    let genres: [Developer]

    enum CodingKeys: String, CodingKey {
        case id, name
        case description
        case descriptionRaw = "description_raw"
        case released
        case backgroundImage = "background_image"
        case rating
        case genres
    }
}

// MARK: - Developer
struct Developer: Codable {
    let id: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case id, name
    }
}
