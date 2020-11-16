//
//  LeaderboardTabBar.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 16.11.20.
//

import SwiftUI

struct LeaderboardTabBar: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                ForEach(LeaderboardCategory.allCases) { category in
                    LeaderboardView(viewModel: LeaderboardViewModel(id: category.rawValue))
                        .tabItem {
                            Text(category.name).font(.system(size: 6, weight: .light, design: .default))
                        }.id(selectedTab)
                }
            }.navigationTitle(LeaderboardCategory(rawValue: selectedTab)!.name)
        }
    }
}
