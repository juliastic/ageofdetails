//
//  PlayerViewModel.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 15.11.20.
//

import Foundation
import Combine

public class PlayerViewModel: ObservableObject, Identifiable {
    var subscriptions: Set<AnyCancellable> = []
    
    @Published var loading: Bool = true
    @Published var error: AoENetError?
    @Published var playerMatchHistory: [PlayerMatchHistory] = []
    @Published var filteredPlayerMatchHistory: [MatchPlayer] = []
    
    let player: Player
    let leaderboardId: Int
        
    init(player: Player, leaderboardId: Int) {
        self.player = player
        self.leaderboardId = leaderboardId
    }
    
    func loadData() {
        AoENet.instance.loadMatchHistory(for: player.steamId, count: 10)
            .receive(on: DispatchQueue.main)
            .map { playerMatchHistories in
                playerMatchHistories.filter { $0.leaderboardId == self.leaderboardId }
            }
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                if case let .failure(error) = value {
                    self.error = error
                }
                self.loading = false
              }, receiveValue: { [weak self] playerMatchHistory in
                guard let self = self else { return }
                self.playerMatchHistory = playerMatchHistory
                self.filteredPlayerMatchHistory = playerMatchHistory.map { match in
                    match.players.filter { $0.id == self.player.id }[0]
                }
            })
            .store(in: &subscriptions)
    }
    
    func averageMatchRating() -> Double {
        var sum = 0.0
        filteredPlayerMatchHistory.forEach { match in sum += Double(match.rating ?? 0) }
        return sum / Double(filteredPlayerMatchHistory.count)
    }
}
