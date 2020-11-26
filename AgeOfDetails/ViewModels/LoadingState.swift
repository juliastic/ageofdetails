//
//  LoadingState.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 25.11.20.
//

import Foundation

enum LoadingState<Value>: Equatable {
    case idle
    case loading
    case failed(Error)
    case loaded(Value)
    
    public static func == (lhs: LoadingState<Value>, rhs: LoadingState<Value>) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle),
             (.loading, .loading):
            return true
        default:
            return false
        }
    }
}
