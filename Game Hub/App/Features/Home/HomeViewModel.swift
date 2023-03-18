//
//  HomeViewModel.swift
//  Game Hub
//
//  Created by Julsapargi Nursam on 16/02/23.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var games: ViewState<[Game]> = .initiate
    private var cancellables = Set<AnyCancellable>()
    
    var gameHubRepository: GameRepositoryProtocol
    
    init(gameHubRepository: GameRepositoryProtocol = GameRepository.shared) {
        self.gameHubRepository = gameHubRepository
    }
    
    func getGame() {
        self.games = .loading
        gameHubRepository.getGames()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: ()
                case .failure(let error):
                    self.games = .error(error: error)
                }
            } receiveValue: { value in
                if value.isEmpty {
                    self.games = .empty
                } else {
                    self.games = .success(data: value)
                }
            }.store(in: &cancellables)
    }
}
