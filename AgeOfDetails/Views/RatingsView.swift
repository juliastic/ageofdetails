//
//  RatingsView.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 27.11.20.
//

import SwiftUI

struct RatingsView: View {
    @ObservedObject var viewModel: PlayerViewModel
    
    @State var selectedId: Int
    
    let geometry: GeometryProxy
    
    var body: some View {
        Picker(selection: $selectedId, label: Text("Categories")) {
            ForEach(LeaderboardCategory.allCases, id: \.self) { category in
                Text(category.shortenedName).tag(category.id)
            }
        }
        .onChange(of: selectedId, perform: { value in
            viewModel.updateActiveLeaderboard(for: value)
        })
        .frame(width: geometry.size.width)
        .pickerStyle(SegmentedPickerStyle())
        if viewModel.activeLeaderboardRating.mappedRatings.isEmpty {
            Text("No recent ratings have been found")
                .font(.system(size: 20, weight: .bold, design: .default))
        } else {
            Text("Rating History")
                .font(.system(size: 20, weight: .bold, design: .default))
                .padding()
            Text("Last played game: " + Date(timeIntervalSince1970: viewModel.activeLeaderboardRating.ratings[0].timestamp).shortFormat())
                .font(.system(size: 15, weight: .light, design: .default))
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
            GeometryReader { reader in
                DataChartLine(data: viewModel.activeLeaderboardRating.mappedRatings, frame: .constant(CGRect(x: 0, y: 0, width: reader.frame(in: .local).width - 60, height: reader.frame(in: .local).height - 20)))
            }
            .frame(width: geometry.frame(in: .local).size.width, height: 250)
            .padding(.horizontal)
        }
    }
    
    init(viewModel: PlayerViewModel, geometry: GeometryProxy) {
        self.viewModel = viewModel
        self.geometry = geometry
        self._selectedId = State(initialValue: viewModel.leaderboardId)
    }
    
}
