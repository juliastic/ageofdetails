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
            Text("\(viewModel.player.rank) " + viewModel.player.name)
            Text(viewModel.player.country?.flag() ?? "")
        }
    }
}
