//
//  AppStatViewModel.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 24.11.20.
//

import Foundation
import Combine

class AppStatsViewModel: LoadableObject {
    @Published private(set) var state: LoadingState<AppStats> = .idle
    
    private var publisher: AnyPublisher<AppStats, AoENetError>?
    private var cancellable: AnyCancellable?
    
    func load() {
        state = .loading
        publisher = AoENet.instance.loadAppStats()
        cancellable = publisher!
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            if case let .failure(error) = value {
                self.state = .failed(error)
            }
          }, receiveValue: { [weak self] appStats in
            guard let self = self else { return }
            self.state = .loaded(appStats)
        })
    }
    
    func resetState() {
        state = .idle
    }
}
