//
//  PlayerViewModel.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 15.11.20.
//

import Foundation
import Combine

class PlayerViewModel: LoadableObject, Identifiable {
    typealias Output = [Rating]
    
    @Published var state: LoadingState<[Rating]> = .idle
    @Published var ratingHistory: [Rating] = []

    private var publisher: AnyPublisher<[Rating], AoENetError>?
    private var cancellable: AnyCancellable?
        
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
    
    func load() {
        publisher = AoENet.instance.loadRatingHistory(for: player.steamId ?? "\(player.id)", leaderboardId: leaderboardId, useSteamId: player.steamId != nil, start: 0, count: 10)
        cancellable = publisher!
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            if case let .failure(error) = value {
                self.state = .failed(error)
            }
          }, receiveValue: { [weak self] ratingHistory in
            guard let self = self else { return }
            self.state = .loaded(ratingHistory)
            self.ratingHistory = ratingHistory
        })
    }
    
    func resetState() {
        state = .idle
    }
}
