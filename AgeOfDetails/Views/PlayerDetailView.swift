//
//  PlayerDetailsView.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 17.11.20.
//

import SwiftUI

struct PlayerDetailView: View {
    @ObservedObject var viewModel: PlayerViewModel

    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                Text(viewModel.player.name)
                Text(viewModel.player.country?.flag() ?? "")
            }.navigationBarTitle(viewModel.player.name).navigationTitle("HI")
        }
    }
}
