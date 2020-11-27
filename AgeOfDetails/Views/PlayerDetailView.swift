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
                        AsyncContentView(source: viewModel, frame: .constant(CGRect(x: 0, y: 0, width: geometry.size.width, height: geometry.size.height))) { ratings in
                            RatingsView(viewModel: viewModel, ratings: ratings, geometry: geometry)
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
