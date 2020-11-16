//
//  PlayersListView.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 15.11.20.
//

import SwiftUI

struct LeaderboardView: View {
    @ObservedObject var viewModel: LeaderboardViewModel
    
    @ViewBuilder
    var body: some View {
        if viewModel.loading {
            ProgressView()
                .onAppear(perform: {
                    if viewModel.loading {
                        viewModel.reload()
                    }
                })
        } else if let error = viewModel.error {
            Label(error.description, systemImage: "exclamationmark.triangle")
        } else if let leaderboard = viewModel.leaderboard {
            List(leaderboard.leaderboard) { player in
              PlayerView(viewModel: PlayerViewModel(player: player))
            }
        }
    }
}
