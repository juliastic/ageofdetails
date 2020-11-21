//
//  PlayerMatchHistory.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 20.11.20.
//

import Foundation

struct PlayerMatchHistory: Codable, Hashable {
    let leaderboardId: Int?
    let matchId: String
    let players: [MatchPlayer]
    
    private enum CodingKeys: String, CodingKey {
        case leaderboardId = "leaderboard_id"
        case matchId = "match_id"
        case players
    }
}
