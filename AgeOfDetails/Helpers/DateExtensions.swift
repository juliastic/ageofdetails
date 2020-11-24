//
//  DateExtensions.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 24.11.20.
//

import Foundation

extension Date {
    func shortFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: self)
    }
}
