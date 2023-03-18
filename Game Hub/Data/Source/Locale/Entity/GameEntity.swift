//
//  GameEntity.swift
//  Game Hub
//
//  Created by Julsapargi Nursam on 04/03/23.
//

import Foundation
import RealmSwift

class GameEntity: Object {
    @Persisted(primaryKey: true) var id = 0
    @Persisted var name = ""
    @Persisted var descriptionRaw = ""
    @Persisted var released = ""
    @Persisted var image = ""
    @Persisted var rating = 0.0
}
