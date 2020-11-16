//
//  LeaderboardCategory.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 16.11.20.
//

import Foundation

enum LeaderboardCategory: Int, CaseIterable, Identifiable {
    var id: Int {
        return rawValue
    }
    
    case unranked = 0
    case singledeathmatch = 1
    case teamdeathmatch = 2
    case singlerandommap = 3
    case teamrandommap = 4
    
    var name: String {
        switch self {
        case .unranked: return "Unkranked"
        case .singledeathmatch: return "1v1 Deathmatch"
        case .teamdeathmatch: return "Team Deathmatch"
        case .singlerandommap: return "1v1 Random Map"
        case .teamrandommap: return "Team Random Map"
        }
    }
}
