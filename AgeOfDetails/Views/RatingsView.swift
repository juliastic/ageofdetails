//
//  RatingsView.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 27.11.20.
//

import SwiftUI

struct RatingsView: View {
    @ObservedObject var viewModel: PlayerViewModel
    
    let geometry: GeometryProxy
    
    var body: some View {
        Text(LeaderboardCategory(rawValue: viewModel.activeLeaderboardRating.id)?.name ?? "")
            .contextMenu {
                ForEach(LeaderboardCategory.allCases) { category in
                    Button(action: {
                        viewModel.updateActiveLeaderboard(for: category.id)
                    }) {
                        Text(category.name)
                    }.disabled(viewModel.activeLeaderboardRating.id == category.id)
                }
            }.padding()
        if viewModel.activeLeaderboardRating.mappedRatings.isEmpty {
            Text("No recent ratings have been found")
                .font(.system(size: 20, weight: .bold, design: .default))
        } else {
            Text("Rating History")
                .font(.system(size: 20, weight: .bold, design: .default))
                .padding()
            Text("Last played game: " + Date(timeIntervalSince1970: viewModel.activeLeaderboardRating.ratings[0].timestamp).shortFormat())
                .font(.system(size: 15, weight: .light, design: .default))
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
            GeometryReader { reader in
                DataChartLine(data: viewModel.activeLeaderboardRating.mappedRatings, frame: .constant(CGRect(x: 0, y: 0, width: reader.frame(in: .local).width - 60, height: reader.frame(in: .local).height - 20)))
            }
            .frame(width: geometry.frame(in: .local).size.width, height: 250)
            .padding(.horizontal)
        }
    }
    
}
