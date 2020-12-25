//
//  WinrateView.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 04.12.20.
//

import SwiftUI

struct WinrateView: View {
    let winrate: Double
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(Color.red)
                .opacity(0.3)
                .frame(width: 345.0, height: 20.0)
            Rectangle()
                .foregroundColor(Color.green)
                .frame(width: 345.0 * CGFloat(winrate), height: 20.0)
        }
    }
}
