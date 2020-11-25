//
//  LoadingView.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 25.11.20.
//

import SwiftUI

struct LoadingView: View {
    var loadAction: () -> Void
        
    var body: some View {
        ProgressView()
            .onAppear(perform: {
                self.loadAction()
            })
    }
}
