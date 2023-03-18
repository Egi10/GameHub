//
//  LocaleDataSource.swift
//  Game Hub
//
//  Created by Julsapargi Nursam on 04/03/23.
//

import Foundation
import Combine
import RealmSwift

protocol LocalDataSourceProtocol {
    func getFavoriteGames() -> AnyPublisher<[GameEntity], Error>
    func getFavoriteGameById(from id: Int) -> AnyPublisher<GameEntity, Error>
    func addGameFavorite(from game: GameEntity) -> AnyPublisher<Bool, Error>
    func removeGameFavorite(from id: Int) -> AnyPublisher<Bool, Error>
}

class LocalDataSource: NSObject {
    
    private let realm: Realm?
    
    init(realm: Realm? = try! Realm()) {
        self.realm = realm
    }
    
    static let shared: LocalDataSourceProtocol = LocalDataSource()
}

extension LocalDataSource: LocalDataSourceProtocol {
    func getFavoriteGameById(from id: Int) -> AnyPublisher<GameEntity, Error> {
        return Future<GameEntity, Error> { completion in
            if let realm = self.realm {
                if let game = realm.object(ofType: GameEntity.self, forPrimaryKey: id) {
                    completion(.success(game))
                } else {
                    completion(.failure(NSError()))
                }
            } else {
                completion(.failure(NSError()))
            }
        }.eraseToAnyPublisher()
    }
    
    func getFavoriteGames() -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            if let realm = self.realm {
                let games: Results<GameEntity> = {
                    realm.objects(GameEntity.self)
                        .sorted(byKeyPath: "name", ascending: true)
                }()
                completion(
                    .success(
                        games.toArray(ofType: GameEntity.self)
                    )
                )
            } else {
                completion(.failure(NSError()))
            }
        }.eraseToAnyPublisher()
    }
    
    func addGameFavorite(from game: GameEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(game, update: .all)
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NSError()))
            }
        }.eraseToAnyPublisher()
    }
    
    func removeGameFavorite(from id: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    let game = realm.object(ofType: GameEntity.self, forPrimaryKey: id)!
                    try realm.write {
                        realm.delete(game)
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NSError()))
            }
        }.eraseToAnyPublisher()
    }
}

extension Results {
  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }
}
