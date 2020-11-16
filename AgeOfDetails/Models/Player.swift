//
//  Player.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 15.11.20.
//

import Foundation

struct Player: Codable, Hashable, Identifiable {
    let id: Int
    let rank: Int
    let rating: Int
    let name: String
    let country: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "profile_id"
        case rank
        case rating
        case name
        case country
    }
}
