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
    }
    
    func loadLeadboard(start: Int, count: Int, id: Int) -> AnyPublisher<LeaderboardData, AoENetError> {
        buildLeaderboardURL(start: start, count: count, id: id)
        return loadAoESingleData(for: LeaderboardData.self)
    }
    
    func loadMatchHistory(for id: String, useSteamId: Bool, start: Int, count: Int) -> AnyPublisher<[PlayerMatchHistory], AoENetError> {
        buildMatchHistoryURL(start: start, count: count, id: id, useSteamId: useSteamId)
        return loadAoEMultipleData(for: PlayerMatchHistory.self)
    }
    
    // REFACTOR THESE METHODS
    
    private func loadAoESingleData<T: Codable>(for data: T.Type) -> AnyPublisher<T, AoENetError> {
        return URLSession.shared.dataTaskPublisher(for: urlComponents.url!)
            .tryMap { response in
              if let httpURLResponse = response.response as? HTTPURLResponse,
                    !(200...299 ~= httpURLResponse.statusCode) {
                throw AoENetError.message("Got an HTTP \(httpURLResponse.statusCode) error.")
              }
              return response.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { AoENetError.map($0) }
            .eraseToAnyPublisher()
    }
    
    private func loadAoEMultipleData<T: Codable>(for data: T.Type) -> AnyPublisher<[T], AoENetError> {
        return URLSession.shared.dataTaskPublisher(for: urlComponents.url!)
            .tryMap { response in
              if let httpURLResponse = response.response as? HTTPURLResponse,
                    !(200...299 ~= httpURLResponse.statusCode) {
                throw AoENetError.message("Got an HTTP \(httpURLResponse.statusCode) error.")
              }
              return response.data
            }
            .decode(type: [T].self, decoder: JSONDecoder())
            .mapError { AoENetError.map($0) }
            .eraseToAnyPublisher()
    }
        
    private func buildLeaderboardURL(start: Int, count: Int, id: Int) {
        urlComponents.path = "/api/leaderboard"
        urlComponents.queryItems = [
            URLQueryItem(name: "game", value: "aoe2de"),
            URLQueryItem(name: "leaderboard_id", value: "\(id)"),
            URLQueryItem(name: "start", value: "\(start)"),
            URLQueryItem(name: "count", value: "\(count)")]
    }
    
    private func buildMatchHistoryURL(start: Int, count: Int, id: String, useSteamId: Bool) {
        urlComponents.path = "/api/player/matches"
        urlComponents.queryItems = [
            URLQueryItem(name: "game", value: "aoe2de"),
            URLQueryItem(name: "start", value: "\(start)"),
            URLQueryItem(name: "count", value: "\(count)"),
            URLQueryItem(name: useSteamId ? "steam_id" : "profile_id", value: id)
        ]
    }
}
