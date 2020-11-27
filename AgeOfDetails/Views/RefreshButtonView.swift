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

    @Binding var dataInitiallyLoaded: Bool
    
    var buttonDisabled: Bool {
        switch source.state {
        case .loading:
            return true
        default:
            return false
        }
    }
        
    @ViewBuilder
    var body: some View {
        Button(action: {
            lastUpdated = Date()
            source.resetState()
        }) {
            if dataInitiallyLoaded {
                VStack {
                    Image(systemName: "arrow.2.circlepath")
                    Spacer()
                    Text(lastUpdated.shortFormat())
                        .font(.system(size: 8, weight: .light, design: .default))
                }
            }
        }
        .disabled(buttonDisabled)
    }
}
