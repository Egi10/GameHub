//
//  GameHubRepository.swift
//  Game Hub
//
//  Created by Julsapargi Nursam on 16/02/23.
//

import Foundation
import Combine
import Alamofire

protocol GameRepositoryProtocol {
    func getGames() -> AnyPublisher<[Game], Error>
    func detailGame(idGame: Int) -> AnyPublisher<DetailGame, Error>
    func getFavoriteGames() -> AnyPublisher<[Game], Error>
    func getFavoriteGameById(from id: Int) -> AnyPublisher<DetailGame, Error>
    func addFavoriteGame(from game: DetailGame) -> AnyPublisher<Bool, Error>
    func removeFavoriteGame(from id: Int) -> AnyPublisher<Bool, Error>
}

class GameRepository: NSObject {
    var remoteHubDataSource: RemoteDataSourceProtocol
    var localHubDataSource: LocalDataSourceProtocol
    
    init(
        remoteHubDataSource: RemoteDataSourceProtocol = RemoteDataSource.shared,
        localHubDataSource: LocalDataSourceProtocol = LocalDataSource.shared
    ) {
        self.remoteHubDataSource = remoteHubDataSource
        self.localHubDataSource = localHubDataSource
    }
    
    static let shared: GameRepositoryProtocol = GameRepository()
}

extension GameRepository: GameRepositoryProtocol {
    func getFavoriteGameById(from id: Int) -> AnyPublisher<DetailGame, Error> {
        return self.localHubDataSource.getFavoriteGameById(from: id)
            .map { entity in
                GameMapper.mapGameEntityToDetailModel(input: entity)
            }
            .eraseToAnyPublisher()
    }
    
    func addFavoriteGame(from game: DetailGame) -> AnyPublisher<Bool, Error> {
        let mapper = GameMapper.mapGameToEntity(input: game)
        return self.localHubDataSource.addGameFavorite(
            from: mapper
        ).eraseToAnyPublisher()
    }
    
    func removeFavoriteGame(from id: Int) -> AnyPublisher<Bool, Error> {
        return self.localHubDataSource.removeGameFavorite(
            from: id
        ).eraseToAnyPublisher()
    }
    
    
    func getFavoriteGames() -> AnyPublisher<[Game], Error> {
        return self.localHubDataSource.getFavoriteGames()
            .map { entity in
                GameMapper.mapGameEntityToModel(input: entity)
            }
            .eraseToAnyPublisher()
    }
    
    func getGames() -> AnyPublisher<[Game], Error> {
        
        return self.remoteHubDataSource.getGames()
            .map { response in
                GameMapper.mapGameResponseToModel(input: response)
            }
            .eraseToAnyPublisher()
    }
    
    func detailGame(idGame: Int) -> AnyPublisher<DetailGame, Error> {
        return self.remoteHubDataSource.detailGame(idGame: idGame)
            .map { response in
                GameMapper.mapDetailGameResponseToModel(input: response)
            }
            .eraseToAnyPublisher()
    }
}
