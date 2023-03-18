//
//  FavoriteViewModel.swift
//  Game Hub
//
//  Created by Julsapargi Nursam on 04/03/23.
//

import Foundation
import Combine

class FavoriteViewModel: ObservableObject {
    @Published var favorite: ViewState<[Game]> = .initiate
    private var cancellables = Set<AnyCancellable>()
    
    var gameHubRepository: GameRepositoryProtocol
    
    init(gameHubRepository: GameRepositoryProtocol = GameRepository.shared) {
        self.gameHubRepository = gameHubRepository
    }
    
    func getFavorite() {
        self.favorite = .loading
        
        gameHubRepository.getFavoriteGames()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: ()
                case .failure(let error):
                    self.favorite = .error(error: error)
                }
            } receiveValue: { value in
                if value.isEmpty {
                    self.favorite = .empty
                } else {
                    self.favorite = .success(data: value)
                }
            }.store(in: &cancellables)
    }
}
