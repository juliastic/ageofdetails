//
//  Rating.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 23.11.20.
//

import Foundation

struct Rating: Codable, Hashable {
    let rating: Int
    
    private enum CodingKeys: String, CodingKey {
        case rating
    }
}
