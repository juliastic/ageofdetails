//
//  LoadableObject.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 25.11.20.
//

import Foundation
import Combine

protocol LoadableObject: ObservableObject {
    associatedtype Output
    var state: LoadingState<Output> { get }
    func load()
    func resetState()
}
