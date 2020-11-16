//
//  PlayerViewModel.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 15.11.20.
//

import Foundation

public class PlayerViewModel: ObservableObject, Identifiable {
    
    let player: Player

    @Published var loading: Bool = true
        
    init(player: Player) {
        self.player = player
    }
    
    // for more advanced information
    func reload() {
        
    }
}
