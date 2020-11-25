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
    @Published var ratingHistory: [Rating] = []
    
    let player: Player
    let leaderboardId: Int
        
    var mappedRatings: [Double] {
        var mapped = ratingHistory.map { rating in Double(rating.rating) }
        mapped.reverse()
        return mapped
    }

    init(player: Player, leaderboardId: Int) {
        self.player = player
        self.leaderboardId = leaderboardId
    }
    
    func loadRatingHistory() {
        AoENet.instance.loadRatingHistory(for: player.steamId ?? "\(player.id)", leaderboardId: leaderboardId, useSteamId: player.steamId != nil, start: 0, count: 10)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                if case let .failure(error) = value {
                    self.error = error
                }
                self.loading = false
              }, receiveValue: { [weak self] ratingHistory in
                guard let self = self else { return }
                self.ratingHistory = ratingHistory
            })
            .store(in: &subscriptions)
    }
}
