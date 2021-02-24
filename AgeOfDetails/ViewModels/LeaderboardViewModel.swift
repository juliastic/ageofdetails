//
//  PlayersViewModel.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 15.11.20.
//

import Foundation
import Combine

class LeaderboardViewModel: LoadableObject {
    @Published private(set) var state: LoadingState<LeaderboardData> = .idle

    private var cancellables: [AnyCancellable] = []

    private var rangeStart = 0
    private var count = 100
    
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    func load() {
        state = .loading
        AoENet.instance.loadLeadboard(start: rangeStart, count: count, id: id)
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
            .store(in: &cancellables)
    }
    
    func set(rangeStart: Int, count: Int) {
        guard count > 0 && rangeStart > 0 else { return }
        self.rangeStart = rangeStart
        self.count = count
    }
    
    func resetState() {
        state = .idle
    }
}
