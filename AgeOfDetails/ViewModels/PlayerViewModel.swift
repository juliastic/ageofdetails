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
    
    var filteredRatings: [Double] {
        return filteredPlayerMatchHistory.map { matchPlayer in Double(matchPlayer.rating ?? 0) }
    }
        
    init(player: Player, leaderboardId: Int) {
        self.player = player
        self.leaderboardId = leaderboardId
    }
    
    func loadData() {
        AoENet.instance.loadMatchHistory(for: player.steamId ?? "\(player.id)", useSteamId: player.steamId != nil, start: 0, count: 30)
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
                if (self.playerMatchHistory.count > 10) {
                    self.playerMatchHistory.removeSubrange(10...self.playerMatchHistory.count - 1)
                }
                self.filteredPlayerMatchHistory = self.playerMatchHistory.map { match in
                    match.players.filter { $0.id == self.player.id || $0.steamId == self.player.steamId }[0]
                }
            })
            .store(in: &subscriptions)
    }
}
