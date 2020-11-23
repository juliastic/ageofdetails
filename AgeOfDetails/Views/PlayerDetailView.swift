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
            VStack(alignment: .leading) {
                Text(viewModel.player.name + " " + (viewModel.player.country ?? "").flag())
                Text("\(winrate * 100)%")
                winrateView
                if viewModel.loading {
                    ProgressView()
                        .onAppear(perform: {
                            if viewModel.loading {
                                viewModel.loadData()
                            }
                        })
                        .alignmentGuide(HorizontalAlignment.center, computeValue: { $0[.bottom] })
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                } else if let error = viewModel.error {
                    Label(error.description, systemImage: "exclamationmark.triangle")
                } else {
                    if viewModel.ratingHistory.isEmpty {
                        Text("No recent ratings have been found").font(.system(size: 20, weight: .bold, design: .default))
                    } else {
                        Text("Recent Ratings").font(.system(size: 20, weight: .bold, design: .default))
                        GeometryReader { reader in
                            PlayerChartLine(viewModel: viewModel, frame: .constant(CGRect(x: 0, y: 0, width: reader.frame(in: .local).width - 60, height: reader.frame(in: .local).height - 10)))
                        }
                        .frame(width: geometry.frame(in: .local).size.width, height: 250)
                        .padding(.horizontal)
                    }
                }
            }
            .navigationBarTitle(viewModel.player.name)
            .padding(.horizontal)
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
