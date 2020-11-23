//
//  LeaderboardMainView.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 16.11.20.
//

import SwiftUI

struct LeaderboardMainView: View {
    var body: some View {
        NavigationView {
            leaderboardScrollView
                .padding(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .navigationTitle("Age of Details")
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    var leaderboardScrollView: some View {
        GeometryReader { geometry in
            ScrollView {
                ForEach(LeaderboardCategory.allCases) { category in
                    NavigationLink(destination: LeaderboardView(viewModel: LeaderboardViewModel(id: category.id))) {
                        VStack {
                            VStack(alignment: .leading) {
                                Text(category.name)
                                    .font(.system(size: 20, weight: .bold, design: .default))
                                Text(category.description)
                                    .font(.system(size: 16, weight: .light, design: .default))
                            }
                            .modifier(CellViewModifier())
                            .frame(width: geometry.size.width, height: 100, alignment: .leading)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1))
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
