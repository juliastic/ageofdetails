//
//  PlayerViewModel.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 15.11.20.
//

import Foundation
import Combine

class PlayerViewModel: LoadableObject, Identifiable {
    @Published private(set) var state: LoadingState<[Rating]> = .idle
    @Published private(set) var multipleLeaderboardRatings: [LeaderboardRating] = []
    @Published private(set) var activeLeaderboardRating: LeaderboardRating = LeaderboardRating(id: 0, ratings: [])
    
    private var cancellables: [AnyCancellable] = []

    let player: Player
    let leaderboardId: Int
    
    init(player: Player, leaderboardId: Int) {
        self.player = player
        self.leaderboardId = leaderboardId
    }
    
    func loadData(for id: Int) {
        AoENet.instance.loadRatingHistory(for: player.steamId ?? "\(player.id)", leaderboardId: id, useSteamId: player.steamId != nil, start: 0, count: 10)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                if case let .failure(error) = value {
                self.state = .failed(error)
                }
            }, receiveValue: { [weak self] ratingHistory in
                guard let self = self else { return }
                if id == self.leaderboardId {
                    self.activeLeaderboardRating = LeaderboardRating(id: id, ratings: ratingHistory)
                    self.state = .loaded(ratingHistory)
                }
                self.multipleLeaderboardRatings.append(LeaderboardRating(id: id, ratings: ratingHistory))
                self.multipleLeaderboardRatings.sort(by: { $0.id < $1.id })
            })
            .store(in: &cancellables)
    }
    
    func updateActiveLeaderboard(for index: Int) {
        activeLeaderboardRating = multipleLeaderboardRatings[index]
    }
    
    func load() {
        for i in 0..<5 {
            loadData(for: i)
        }
    }
    
    func resetState() {
        state = .idle
    }
}
