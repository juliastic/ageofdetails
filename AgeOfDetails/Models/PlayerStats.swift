//
//  PlayerStats.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 24.11.20.
//

import Foundation

struct PlayerStats: Codable, Hashable {
    let steam: Double?
    let multiplayer: Double?
    let inGame: Int?
    
    private enum CodingKeys: String, CodingKey {
        case steam
        case multiplayer
        case inGame = "in_game"
    }
}
