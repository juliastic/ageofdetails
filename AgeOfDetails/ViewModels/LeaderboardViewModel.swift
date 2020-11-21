//
//  PlayersViewModel.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 15.11.20.
//

import Foundation
import Combine

public class LeaderboardViewModel: ObservableObject {
    var subscriptions: Set<AnyCancellable> = []
    
    @Published var leaderboard: LeaderboardData?
    @Published var loading: Bool = true
    @Published var error: AoENetError?
    @Published var players: [PlayerViewModel] = []
    
    private var playerCount = 0
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    func loadData() {
        AoENet.instance.loadLeadboard(start: playerCount, count: Constants.fetch, id: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                if case let .failure(error) = value {
                    self.error = error
                }
                self.loading = false
              }, receiveValue: { [weak self] leaderboard in
                guard let self = self else { return }
                self.leaderboard = leaderboard
                leaderboard.players.forEach() { player in
                    self.players.append(PlayerViewModel(player: player, leaderboardId: self.id))
                self.playerCount += leaderboard.players.count
                }
            })
            .store(in: &subscriptions)
    }
}

enum Constants {
    static let fetch = 100
}
