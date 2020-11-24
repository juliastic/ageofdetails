//
//  RefreshButtonView.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 24.11.20.
//

import SwiftUI

struct RefreshButtonView: View {
    @State var lastUpdated = Date()
    
    @Binding var dataInitiallyLoaded: Bool
    @Binding var viewModelLoading: Bool
    
    var body: some View {
        Button(action: {
            viewModelLoading = true
            lastUpdated = Date()
        }) {
            if dataInitiallyLoaded {
                VStack {
                    Image(systemName: "arrow.2.circlepath")
                        .rotationEffect(.degrees(viewModelLoading ? 360.0 : 0.0))
                        .animation(viewModelLoading ? Animation.linear(duration: 1) : nil)
                    Spacer()
                    Text(lastUpdated.shortFormat())
                        .font(.system(size: 8, weight: .light, design: .default))
                }
            }
        }
    }
}
