//
//  DividerModifier.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 24.02.21.
//

import SwiftUI

struct DividerModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.background(Color.black)
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
    }
}
