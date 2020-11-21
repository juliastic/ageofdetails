//
//  LeaderboardMainView.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 16.11.20.
//

import SwiftUI

struct LeaderboardMainView: View {
    @State private var currentId: Int = 0

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                HStack {
                    Menu("Leaderboards") {
                        ForEach(LeaderboardCategory.allCases) { category in
                            Button(category.name) {
                                currentId = category.id
                            }
                        }
                    }
                    Menu("Views") {
                        Button("Clasic View", action: {})
                        Button("Map View", action: {})
                    }
                }.padding(EdgeInsets(top: CGFloat(10), leading: CGFloat(0), bottom: CGFloat(0), trailing: CGFloat(0)))
                LeaderboardView(viewModel: LeaderboardViewModel(id: currentId))
            }
            .padding()
            .navigationTitle(LeaderboardCategory(rawValue: currentId)!.name)
        }
    }
}
