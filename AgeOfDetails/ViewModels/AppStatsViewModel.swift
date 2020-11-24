//
//  AppStatViewModel.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 24.11.20.
//

import Foundation
import Combine

public class AppStatsViewModel: ObservableObject {
    var subscriptions: Set<AnyCancellable> = []
    
    @Published var loading: Bool = true
    @Published var error: AoENetError?
    @Published var appStats: AppStats?
    
    private var reversedGameStats: [GameStats] {
        if let appStats = appStats {
            var gameStats = appStats.gameStats
            gameStats = gameStats.reversed()
            return gameStats
        }
        return []
    }
    
    func loadData() {
        AoENet.instance.loadAppStats()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                if case let .failure(error) = value {
                    self.error = error
                }
                self.loading = false
              }, receiveValue: { [weak self] appStats in
                guard let self = self else { return }
                self.appStats = appStats
            })
            .store(in: &subscriptions)
    }
    
    func lastInGameValue() -> (Int, Date) {
        for gameStat in reversedGameStats {
            if let inGame = gameStat.playerStats.inGame {
                return (inGame, Date(timeIntervalSince1970: gameStat.time))
            }
        }
        return (0, Date())
    }
}
