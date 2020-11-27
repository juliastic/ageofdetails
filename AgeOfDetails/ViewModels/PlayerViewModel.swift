//
//  PlayerViewModel.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 15.11.20.
//

import Foundation
import Combine

class PlayerViewModel: LoadableObject, Identifiable {
    @Published var state: LoadingState<[Rating]> = .idle
    @Published var multipleLeaderboardRatings: [LeaderboardRating] = []
    
    private var publishers: [AnyPublisher<[Rating], AoENetError>] = []
    private var cancellables: [AnyCancellable] = []

    let player: Player
    let leaderboardId: Int
    
    init(player: Player, leaderboardId: Int) {
        self.player = player
        self.leaderboardId = leaderboardId
    }
    
    func loadData(for id: Int) {
        publishers.append(AoENet.instance.loadRatingHistory(for: player.steamId ?? "\(player.id)", leaderboardId: id, useSteamId: player.steamId != nil, start: 0, count: 10))
        cancellables.append(publishers[publishers.count - 1]
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            if case let .failure(error) = value {
                self.state = .failed(error)
            }
          }, receiveValue: { [weak self] ratingHistory in
            guard let self = self else { return }
            if id == self.leaderboardId {
                self.state = .loaded(ratingHistory)
            }
            self.multipleLeaderboardRatings.append(LeaderboardRating(id: id, ratings: ratingHistory))
            self.multipleLeaderboardRatings.sort(by: { $0.id < $1.id })
          }))
    }
    
    func ratings(for index: Int) -> [Double] {
        return multipleLeaderboardRatings[index].mappedRatings
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
