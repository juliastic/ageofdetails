//
//  RefreshButtonView.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 24.11.20.
//

import SwiftUI

struct RefreshButtonView<Source: LoadableObject>: View {
    @ObservedObject var source: Source

    @State var lastUpdated = Date()
    @State var loading: Bool = false

    @Binding var dataInitiallyLoaded: Bool
        
    @ViewBuilder
    var body: some View {
        Button(action: {
            lastUpdated = Date()
            source.resetState()
        }) {
            if dataInitiallyLoaded {
                VStack {
                    switch source.state {
                    case .loading, .idle:
                        Image(systemName: "arrow.2.circlepath")
                            .rotationEffect(.degrees(360.0))
                            .animation(Animation.linear(duration: 10).repeatForever(autoreverses: false))
                    default:
                        Image(systemName: "arrow.2.circlepath")
                    }
                    Spacer()
                    Text(lastUpdated.shortFormat())
                        .font(.system(size: 8, weight: .light, design: .default))
                }
            }
        }
    }
}
