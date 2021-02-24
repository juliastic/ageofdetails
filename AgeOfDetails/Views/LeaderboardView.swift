//
//  PlayersListView.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 15.11.20.
//

import SwiftUI

struct LeaderboardView: View {
    @ObservedObject var viewModel: LeaderboardViewModel
    
    @State private var dataInitiallyLoaded = false
    @State private var lastUpdated = Date()
    
    @ViewBuilder
    var body: some View {
        GeometryReader { geometry in
            VStack {
                LeaderboardFilterMenuView(source: viewModel, lastUpdated: $lastUpdated)
                AsyncContentView(source: viewModel, frame: .constant(CGRect(x: 0, y: 0, width: geometry.size.width, height: geometry.size.height))) { leaderboard in
                    GeometryReader { geometry in
                        ScrollView {
                            Divider()
                                .modifier(DividerModifier())
                            ForEach(leaderboard.players) { player in
                                NavigationLink(destination: PlayerDetailView(viewModel: PlayerViewModel(player: player, leaderboardId: leaderboard.id))) {
                                    VStack {
                                        VStack {
                                            PlayerView(viewModel: PlayerViewModel(player: player, leaderboardId: leaderboard.id))
                                        }
                                        .frame(width: geometry.size.width - 20, height: 70, alignment: .leading)
                                        .background(Color.green)
                                        .cornerRadius(10)
                                        Divider()
                                            .modifier(DividerModifier())
                                    }
                                }
                            }
                        }
                        .cornerRadius(10)
                        .padding(10)
                        .onAppear {
                            dataInitiallyLoaded = true
                        }
                    }
                }
                .navigationTitle(LeaderboardCategory(rawValue: viewModel.id)?.name ?? "")
                .navigationBarItems(trailing: HStack {
                    RefreshButtonView(source: viewModel, dataInitiallyLoaded: $dataInitiallyLoaded, lastUpdated: $lastUpdated)
                })
            }
        }
    }
}
