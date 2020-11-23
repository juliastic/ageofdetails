//
//  PlayerView.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 15.11.20.
//

import SwiftUI

struct PlayerView: View {
    @ObservedObject var viewModel: PlayerViewModel
    
    @ViewBuilder
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(viewModel.player.rank) " + viewModel.player.name + " " + (viewModel.player.country ?? "").flag())
                .font(.system(size: 16, weight: .bold, design: .default))
            Text("Rating: \(viewModel.player.rating)")
                .font(.system(size: 14, weight: .light, design: .default))
        }
        .modifier(CellViewModifier())
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 2))
    }
}
