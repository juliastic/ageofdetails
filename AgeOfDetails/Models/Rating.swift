//
//  Rating.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 23.11.20.
//

import Foundation

struct Rating: Codable, Hashable {
    let rating: Int
    let timestamp: Double
    let streak: Int
    let losses: Int
    let wins: Int
    
    private enum CodingKeys: String, CodingKey {
        case rating
        case timestamp
        case streak
        case losses = "num_losses"
        case wins = "num_wins"
    }
}
