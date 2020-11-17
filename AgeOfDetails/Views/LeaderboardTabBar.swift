//
//  LeaderboardTabBar.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 16.11.20.
//

import SwiftUI

struct LeaderboardTabBar: View {
    @State private var selectedTab: Int = 0
    
    init() {
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().tintColor = .clear
        UITabBar.appearance().backgroundColor = .clear
        UITabBar.appearance().shadowImage = UIImage()
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                TabView(selection: $selectedTab) {
                    ForEach(LeaderboardCategory.allCases) { category in
                        LeaderboardView(viewModel: LeaderboardViewModel(id: category.rawValue))
                            .tabItem {
                                Text(category.name).font(.system(size: 6, weight: .light, design: .default))
                            }.id(selectedTab)
                    }
                }
                .navigationTitle(LeaderboardCategory(rawValue: selectedTab)!.name)
            }
        }
    }
}
