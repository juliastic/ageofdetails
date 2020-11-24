//
//  PlayerDetailsView.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 17.11.20.
//

import SwiftUI

struct PlayerDetailView: View {
    @ObservedObject var viewModel: PlayerViewModel
    
    let winrate: Double
    
    init(viewModel: PlayerViewModel) {
        self.viewModel = viewModel
        winrate = Double(viewModel.player.wins) / Double(viewModel.player.wins + viewModel.player.losses)
    }
    
    @ViewBuilder
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                    VStack(alignment: .leading) {
                        Text("Player Information")
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .padding()
                        VStack(alignment: .leading) {
                            Text("Name: " + viewModel.player.name)
                            Text("Country: " + (viewModel.player.country ?? "").flag())
                            Text("Winrate: \(Int(winrate * 100))%")
                            winrateView
                            Text("Played Games: \(viewModel.player.games)")
                        }
                        .padding(EdgeInsets(top: 2, leading: 10, bottom: 0, trailing: 0))
                        .font(.system(size: 15, weight: .light, design: .default))
                        if viewModel.loading {
                            ProgressView()
                                .onAppear(perform: {
                                    if viewModel.loading {
                                        viewModel.loadRatingHistory()
                                    }
                                })
                                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                        } else if let error = viewModel.error {
                            Label(error.description, systemImage: "exclamationmark.triangle")
                        } else {
                            if viewModel.ratingHistory.isEmpty {
                                Text("No recent ratings have been found")
                                    .font(.system(size: 20, weight: .bold, design: .default))
                            } else {
                                Text("Rating History")
                                    .font(.system(size: 20, weight: .bold, design: .default))
                                    .padding()
                                Text("Last played game: " + Date(timeIntervalSince1970: viewModel.ratingHistory[0].timestamp).shortFormat())
                                    .font(.system(size: 15, weight: .light, design: .default))
                                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                                GeometryReader { reader in
                                    PlayerChartLine(viewModel: viewModel, frame: .constant(CGRect(x: 0, y: 0, width: reader.frame(in: .local).width - 60, height: reader.frame(in: .local).height - 20)))
                                }
                                .frame(width: geometry.frame(in: .local).size.width, height: 250)
                                .padding(.horizontal)
                            }
                        }
                    }
                    .navigationBarTitle(viewModel.player.name)
            }
        }
    }
    
    var winrateView: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(Color.red)
                .opacity(0.3)
                .frame(width: 345.0, height: 20.0)
            Rectangle()
                .foregroundColor(Color.green)
                .frame(width: 345.0 * CGFloat(winrate), height: 20.0)
        }
    }
}
