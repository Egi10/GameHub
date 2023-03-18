//
//  RemoteDataSource.swift
//  Game Hub
//
//  Created by Julsapargi Nursam on 01/03/23.
//

import Foundation
import Combine
import Alamofire

protocol RemoteDataSourceProtocol {
    func getGames() -> AnyPublisher<[GameResponse], Error>
    func detailGame(idGame: Int) -> AnyPublisher<DetailGameResponse, Error>
}

class RemoteDataSource: NSObject {
    
    override init() {}
    
    static let shared: RemoteDataSourceProtocol = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func getGames() -> AnyPublisher<[GameResponse], Error> {
        
        return Future<[GameResponse], Error> { completion in
            // if let url pada Swift adalah sebuah cara untuk melakukan optional binding pada sebuah nilai URL yang mungkin nil atau kosong.
            if let url = URL(string: "https://api.rawg.io/api/games?key=c4764cb2996a41469198de3bb933f097&page_size=20") {
                AF.request(url, method: .get)
                    .validate()
                    .responseDecodable(of: GamesResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.games))
                        case.failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    func detailGame(idGame: Int) -> AnyPublisher<DetailGameResponse, Error> {
        return Future<DetailGameResponse, Error> { completion in
            if let url = URL(string: "https://api.rawg.io/api/games/\(idGame)?key=c4764cb2996a41469198de3bb933f097") {
                AF.request(url, method: .get)
                    .validate()
                    .responseDecodable(of: DetailGameResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}
