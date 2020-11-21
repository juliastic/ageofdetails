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
                        .alignmentGuide(VerticalAlignment.center, computeValue: { $0[.bottom] })
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                } else if let error = viewModel.error {
                    Label(error.description, systemImage: "exclamationmark.triangle")
                } else {
                    barView
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
        }.padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))
    }
    
    var barView: some View {
        HStack {
            ForEach(viewModel.filteredPlayerMatchHistory, id: \.self) { matchPlayer in
                VStack {
                    Spacer()
                    Rectangle()
                        .fill(Color.green)
                        .frame(width: 20, height: barHeight(for: matchPlayer.rating))
                    Text("\(matchPlayer.rating ?? 0)")
                        .font(.footnote)
                        .frame(height: 20)
                    
                }
            }
        }.padding(.horizontal)
    }
    
    func barHeight(for value: Int?) -> CGFloat {
        return CGFloat((Double(value ?? 0) / viewModel.averageMatchRating()) * 10)
    }
}
