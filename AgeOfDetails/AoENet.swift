//
//  AoENet.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 15.11.20.
//

import Foundation
import Combine

class AoENet {
    static let instance = AoENet()
    
    var urlComponents: URLComponents
    
    private init() {
        urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "aoe2.net"
        urlComponents.path = "/api/leaderboard"
    }
    
    func loadLeadboard(start: Int, count: Int, id: Int) -> AnyPublisher<LeaderboardData, AoENetError> {
        buildLeaderboardURL(start: start, count: count, id: id)
        return URLSession.shared.dataTaskPublisher(for: urlComponents.url!)
            .tryMap { response in
              if let httpURLResponse = response.response as? HTTPURLResponse,
                    !(200...299 ~= httpURLResponse.statusCode) {
                throw AoENetError.message("Got an HTTP \(httpURLResponse.statusCode) error.")
              }
              return response.data
            }
            .decode(type: LeaderboardData.self, decoder: JSONDecoder())
            .mapError { AoENetError.map($0) }
            .eraseToAnyPublisher()
    }
    
    func loadPlayerInformation(id: Int) {
        
    }
    
    private func buildLeaderboardURL(start: Int, count: Int, id: Int) {
        urlComponents.queryItems = [
            URLQueryItem(name: "game", value: "aoe2de"),
            URLQueryItem(name: "leaderboard_id", value: "\(id)"),
            URLQueryItem(name: "start", value: "\(start)"),
            URLQueryItem(name: "count", value: "\(count)")]
    }
    
}
