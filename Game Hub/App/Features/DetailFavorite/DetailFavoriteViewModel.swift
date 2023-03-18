//
//  DetailFavoriteViewModel.swift
//  Game Hub
//
//  Created by Julsapargi Nursam on 04/03/23.
//

import Foundation
import Combine

class DetailFavoriteViewModel: ObservableObject {
    @Published var favorite: ViewState<DetailGame> = .initiate
    @Published var isFavorite: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    var gameHubRepository: GameRepositoryProtocol
    
    init(gameHubRepository: GameRepositoryProtocol = GameRepository.shared) {
        self.gameHubRepository = gameHubRepository
    }
    
    func getFavoriteById(from idGame: Int) {
        self.favorite = .loading
        
        gameHubRepository.getFavoriteGameById(from: idGame)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: ()
                case .failure(let error):
                    self.isFavorite = false
                    self.favorite = .error(error: error)
                }
            } receiveValue: { value in
                self.isFavorite = true
                self.favorite = .success(data: value)
            }.store(in: &cancellables)
    }
    
    func removeGameFavorite(from id: Int) {
        gameHubRepository.removeFavoriteGame(from: id)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: ()
                case .failure:
                    self.isFavorite = true
                }
            } receiveValue: { value in
                self.isFavorite = false
            }.store(in: &cancellables)
    }
    
    func addGameFavorite(detailGame: DetailGame) {
        gameHubRepository.addFavoriteGame(from: detailGame)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: ()
                case .failure:
                    self.isFavorite = false
                }
            } receiveValue: { value in
                self.isFavorite = true
            }.store(in: &cancellables)
    }
}

