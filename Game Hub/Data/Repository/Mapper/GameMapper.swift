//
//  GameMapper.swift
//  Game Hub
//
//  Created by Julsapargi Nursam on 01/03/23.
//

import Foundation

final class GameMapper {
    static func mapGameResponseToModel(
        input gameResponse: [GameResponse]
    ) -> [Game] {
        return gameResponse.map { result in
            return Game(
                id: result.id ?? 0,
                name: result.name ?? "",
                released: result.released ?? "",
                image: result.image ?? "",
                rating: result.rating ?? 0.0,
                playtime: result.playtime ?? 0
            )
        }
    }
    
    static func mapDetailGameResponseToModel(
        input detailGameResponse: DetailGameResponse
    ) -> DetailGame {
        return DetailGame(
            id: detailGameResponse.id,
            name: detailGameResponse.name,
            description: detailGameResponse.descriptionRaw,
            released: detailGameResponse.released,
            image: detailGameResponse.backgroundImage,
            rating: detailGameResponse.rating,
            genres: detailGameResponse.genres.map { genre in
                return genre.name
            }
        )
    }
    
    static func mapGameEntityToModel(
        input gameEntity: [GameEntity]
    ) -> [Game] {
        return gameEntity.map { result in
            return Game(
                id: result.id,
                name: result.name,
                released: result.released,
                image: result.image,
                rating: result.rating,
                playtime: 0
            )
        }
    }
    
    static func mapGameEntityToDetailModel(
        input gameEntity: GameEntity
    ) -> DetailGame {
        return DetailGame(
            id: gameEntity.id,
            name: gameEntity.name,
            description: gameEntity.descriptionRaw,
            released: gameEntity.released,
            image: gameEntity.image,
            rating: gameEntity.rating,
            genres: []
        )
    }
    
    static func mapGameToEntity(
        input game: DetailGame
    ) -> GameEntity {
        let entity = GameEntity()
        entity.id = game.id
        entity.name = game.name
        entity.descriptionRaw = game.description
        entity.released = game.released
        entity.image = game.image
        entity.rating = game.rating
        return entity
    }
}
