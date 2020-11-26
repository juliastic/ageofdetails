//
//  AsyncContentView.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 25.11.20.
//

import SwiftUI
import Combine


// Inspired by https://www.swiftbysundell.com/articles/handling-loading-states-in-swiftui/
struct AsyncContentView<Source: LoadableObject, Content: View>: View {
    @ObservedObject var source: Source
    @Binding var frame: CGRect?

    var content: (Source.Output) -> Content

    init(source: Source, frame: Binding<CGRect?> = .constant(nil),
         @ViewBuilder content: @escaping (Source.Output) -> Content) {
        self.source = source
        self.content = content
        self._frame = frame
    }
    
    var body: some View {
        switch source.state {
        case .idle:
            Color.clear.onAppear(perform: source.load)
        case .loading:
            ProgressView()
                .frame(width: frame?.width, height: frame?.height, alignment: .center)
        case .failed(let error):
            Label(error.localizedDescription, systemImage: "exclamationmark.triangle")
        case .loaded(let output):
            content(output)
        }
    }
}
