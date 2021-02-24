//
//  LeaderboardFilterMenuView.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 24.02.21.
//

import SwiftUI

struct LeaderboardFilterMenuView<Source: LeaderboardViewModel>: View {
    @ObservedObject var source: Source
    
    @State private var showMenu = false
    @State private var rangeStartString = ""
    @State private var countString = ""
    @State private var showAlert = false
    
    @Binding var lastUpdated: Date
    
    var buttonDisabled: Bool {
        switch source.state {
        case .loading:
            return true
        default:
            return false
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Filter Content")
                    .font(.system(size: 16, weight: .bold, design: .default))
                Image(systemName: showMenu ? "arrow.up" : "arrow.down")
            }.onTapGesture {
                showMenu.toggle()
            }
            if showMenu {
                HStack {
                    VStack {
                        Text("Start")
                            .font(.system(size: 16, weight: .light, design: .default))
                        TextField("Range Start", text: $rangeStartString).keyboardType(.numberPad)
                            .font(.system(size: 16, weight: .light, design: .default))
                    }.padding(5)
                    VStack {
                        Text("Count")
                            .font(.system(size: 16, weight: .light, design: .default))
                        TextField("Count", text: $countString).keyboardType(.numberPad)
                            .font(.system(size: 16, weight: .light, design: .default))
                    }.padding(5)
                }
                Button(action: {
                    let rangeStart = Int(rangeStartString) ?? 0
                    let count = Int(countString) ?? 0
                    showAlert = rangeStart == 0 || count == 0
                    if !showAlert {
                        source.set(rangeStart: rangeStart, count: count)
                        source.resetState()
                        lastUpdated = Date()
                    }
                }, label: {
                    Text("Filter")
                })
                .alert(isPresented: $showAlert, content: {
                    Alert(title: Text("Invalid Input"))
                })
                .disabled(buttonDisabled)
            }
        }
    }
}
