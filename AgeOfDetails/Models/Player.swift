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
    let country: String?
    let previousRating: Int?
    let highestRating: Int
    let streak: Int
    let lowestStreak: Int
    let games: Int
    let wins: Int
    let losses: Int
    let lastMatchTime: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id = "profile_id"
        case rank
        case rating
        case name
        case country
        case previousRating = "previous_rating"
        case highestRating = "highest_rating"
        case streak
        case lowestStreak = "lowest_streak"
        case games
        case wins
        case losses
        case lastMatchTime = "last_match_time"
    }
}
