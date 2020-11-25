//
//  LeaderboardMainView.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 16.11.20.
//

import SwiftUI

struct LeaderboardMainView: View {
    @ObservedObject var viewModel = AppStatsViewModel()

    @State private var dataInitiallyLoaded = false
    
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
                VStack(alignment: .leading) {
                    HStack {
                        Text("In Game Stats")
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        Spacer()
                        RefreshButtonView(dataInitiallyLoaded: $dataInitiallyLoaded, viewModelLoading: $viewModel.loading)
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    }
                    if viewModel.loading {
                        LoadingView(loadAction: viewModel.loadData)
                            .padding(EdgeInsets(top: dataInitiallyLoaded ? -10 : 0, leading: 0, bottom: 0, trailing: 0))
                    } else if let error = viewModel.error {
                        Label(error.description, systemImage: "exclamationmark.triangle")
                    } else {
                        Text("Online: \(viewModel.lastInGameValue().0)")
                            .font(.system(size: 12, weight: .light, design: .default))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .onAppear {
                                dataInitiallyLoaded = true
                            }
                    }
                    Text("Leaderboards")
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
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
                                .frame(width: geometry.size.width, height: 80, alignment: .leading)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black, lineWidth: 1))
                                Divider()
                                    .background(Color.black)
                                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                            }
                        }
                    }
                    .disabled(viewModel.loading)
                }
            }
            .cornerRadius(10)
        }
    }
}
