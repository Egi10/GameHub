//
//  DetailGameViewModel.swift
//  Game Hub
//
//  Created by Julsapargi Nursam on 19/02/23.
//

import Foundation
import Combine

class DetailGameViewModel: ObservableObject {
    
    @Published var detailGame: ViewState<DetailGameResponse> = .initiate
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
}
