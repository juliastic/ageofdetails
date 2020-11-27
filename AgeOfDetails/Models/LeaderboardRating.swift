//
//  LeaderboardRating.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 27.11.20.
//

import Foundation

struct LeaderboardRating: Hashable, Identifiable {
    let id: Int
    let ratings: [Rating]
    
    var mappedRatings: [Double] {
        return ratings.map { Double($0.rating) }.reversed()
    }
}
