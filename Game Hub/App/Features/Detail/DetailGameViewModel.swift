//
//  DetailGameViewModel.swift
//  Game Hub
//
//  Created by Julsapargi Nursam on 19/02/23.
//

import Foundation
import Combine

class DetailGameViewModel: ObservableObject {
    
    @Published var detailGame: ViewState<DetailGame> = .initiate
    @Published var isFavorite: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    var gameHubRepository: GameRepositoryProtocol
    
    init(gameHubRepository: GameRepositoryProtocol = GameRepository.shared) {
        self.gameHubRepository = gameHubRepository
    }
    
    func getDetailGame(idGame: Int) {
        self.detailGame = .loading
        gameHubRepository.detailGame(idGame: idGame)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: ()
                case .failure(let error):
                    self.detailGame = .error(error: error)
                }
            } receiveValue: { value in
                self.detailGame = .success(data: value)
            }.store(in: &cancellables)
    }
    
    func getGameFavoriteById(idGame: Int) {
        gameHubRepository.getFavoriteGameById(from: idGame)
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
}
