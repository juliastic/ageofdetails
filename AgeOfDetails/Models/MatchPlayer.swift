//
//  MatchPlayer.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 20.11.20.
//

import Foundation

struct MatchPlayer: Codable, Hashable, Identifiable {
    let steamId: String?
    let rating: Int?
    let id: Int?
    
    private enum CodingKeys: String, CodingKey {
        case rating
        case id = "profile_id"
        case steamId = "steam_id"
    }
}
