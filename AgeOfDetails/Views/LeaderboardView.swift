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
        GeometryReader { geometry in
            if viewModel.loading {
                ProgressView()
                    .onAppear(perform: {
                        if viewModel.loading {
                            viewModel.loadData()
                        }
                    }).frame(width: geometry.size.width, height: geometry.size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            } else if let error = viewModel.error {
                Label(error.description, systemImage: "exclamationmark.triangle")
            } else {
                playerScrollView
            }
        }
    }
    
    var playerScrollView: some View {
        GeometryReader { geometry in
            ScrollView {
                ForEach(viewModel.players) { playerViewModel in
                    NavigationLink(destination: PlayerDetailView(viewModel: playerViewModel)) {
                        VStack {
                            VStack {
                                PlayerView(viewModel: playerViewModel)
                                    .frame(width: geometry.size.width, alignment: .leading)
                            }
                            .frame(width: geometry.size.width, height: 70, alignment: .leading)
                            .background(Color.green)
                            .cornerRadius(10)
                            Divider()
                                .background(Color.black)
                                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        }
                    }
                }
            }
            .cornerRadius(10)
        }
    }
}
