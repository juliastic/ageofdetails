//
//  GameStats.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 24.11.20.
//

import Foundation

struct GameStats: Codable, Hashable {
    let time: Double
    let playerStats: PlayerStats
    
    private enum CodingKeys: String, CodingKey {
        case time
        case playerStats = "num_players"
    }
}
