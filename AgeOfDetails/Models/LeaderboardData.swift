//
//  LeaderboardData.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 15.11.20.
//

import Foundation

struct LeaderboardData: Codable, Hashable {
    let total: Int
    let id: Int
    let start: Int
    let count: Int
    let players: [Player]
    
    private enum CodingKeys: String, CodingKey {
        case total
        case id = "leaderboard_id"
        case start
        case count
        case players = "leaderboard"
    }
}
