//
//  StringExtensions.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 17.11.20.
//

import Foundation

extension String {
    /*
     Inspired by https://stackoverflow.com/a/30403199/3556004
     */
    func flag() -> String {
        let base: UInt32 = 127397
        var flag = ""
        for value in self.uppercased().unicodeScalars {
            flag.unicodeScalars.append(UnicodeScalar(base + value.value)!)
        }
        return flag
    }
}
