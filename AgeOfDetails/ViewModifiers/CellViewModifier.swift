//
//  CellViewModifier.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 23.11.20.
//

import SwiftUI

struct CellViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            content
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
            Spacer()
            Image(systemName: "chevron.right")
                .frame(alignment: .trailing)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
        }
        .padding(.vertical)
    }
}
