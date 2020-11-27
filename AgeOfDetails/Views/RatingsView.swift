//
//  RatingsView.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 27.11.20.
//

import SwiftUI

struct RatingsView: View {
    @ObservedObject var viewModel: PlayerViewModel
    
    @State var activeLeaderboard: Int = -1

    let ratings: [Rating]
    let geometry: GeometryProxy
    
    var body: some View {
        Text(LeaderboardCategory(rawValue: activeLeaderboard == -1 ? viewModel.leaderboardId : activeLeaderboard)?.name ?? "")
            .contextMenu {
                ForEach(LeaderboardCategory.allCases) { category in
                    Button(action: {
                        activeLeaderboard = category.id
                    }) {
                        Text(category.name)
                    }.disabled(viewModel.ratings(for: category.id).count == 0)
                }
            }.padding()
        if ratings.isEmpty {
            Text("No recent ratings have been found")
                .font(.system(size: 20, weight: .bold, design: .default))
        } else {
            Text("Rating History")
                .font(.system(size: 20, weight: .bold, design: .default))
                .padding()
            Text("Last played game: " + Date(timeIntervalSince1970: ratings[0].timestamp).shortFormat())
                .font(.system(size: 15, weight: .light, design: .default))
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
            GeometryReader { reader in
                DataChartLine(data: viewModel.ratings(for: activeLeaderboard == -1 ? viewModel.leaderboardId : activeLeaderboard), frame: .constant(CGRect(x: 0, y: 0, width: reader.frame(in: .local).width - 60, height: reader.frame(in: .local).height - 20)))
            }
            .frame(width: geometry.frame(in: .local).size.width, height: 250)
            .padding(.horizontal)
        }
    }
    
}
