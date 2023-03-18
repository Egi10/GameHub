//
//  DetailGame.swift
//  Game Hub
//
//  Created by Julsapargi Nursam on 04/03/23.
//

import Foundation

struct DetailGame: Hashable, Codable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let released: String
    let image: String
    let rating: Double
    let genres: [String]
}
