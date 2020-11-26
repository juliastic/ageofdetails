//
//  AppStats.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 24.11.20.
//

import Foundation

struct AppStats: Codable, Hashable {
    let appId: Int
    let gameStats: [GameStats]
    
    private enum CodingKeys: String, CodingKey {
        case appId = "app_id"
        case gameStats = "player_stats"
    }
    
    func lastInGameValue() -> (Int, Date) {
        var reversedGameStats = gameStats
        reversedGameStats.reverse()
        for gameStat in reversedGameStats {
            if let inGame = gameStat.playerStats.inGame {
                return (inGame, Date(timeIntervalSince1970: gameStat.time))
            }
        }
        return (0, Date())
    }
}
