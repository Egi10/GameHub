//
//  Game.swift
//  Game Hub
//
//  Created by Julsapargi Nursam on 01/03/23.
//

import Foundation

struct Game: Hashable, Codable, Identifiable {
    let id: Int
    let name: String
    let released: String
    let image: String
    let rating: Double
    let playtime: Int
}
