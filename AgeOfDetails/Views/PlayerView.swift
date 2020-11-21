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
        HStack {
            VStack(alignment: .leading) {
                Text("\(viewModel.player.rank) " + viewModel.player.name)
                Text(viewModel.player.country?.flag() ?? "")
            }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
        }.padding(.vertical)
    }
}
