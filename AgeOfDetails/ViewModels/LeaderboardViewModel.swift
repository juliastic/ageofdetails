//
//  PlayersViewModel.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 15.11.20.
//

import Foundation
import Combine

class LeaderboardViewModel: LoadableObject {
    @Published var state: LoadingState<LeaderboardData> = .idle

    var publisher: AnyPublisher<LeaderboardData, AoENetError>?
    private var cancellable: AnyCancellable?
        
    private var playerCount = 0
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    func load() {
        state = .loading
        publisher = AoENet.instance.loadLeadboard(start: playerCount, count: Constants.fetch, id: id)
        cancellable = publisher!
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                if case let .failure(error) = value {
                    self.state = .failed(error)
                }
              }, receiveValue: { [weak self] leaderboard in
                guard let self = self else { return }
                self.state = .loaded(leaderboard)
            })
    }
    
    func resetState() {
        state = .idle
    }
    
}

enum Constants {
    static let fetch = 100
}
