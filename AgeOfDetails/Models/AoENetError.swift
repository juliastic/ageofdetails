//
//  AoENetError.swift
//  AgeOfDetails
//
//  Created by Julia Grill on 15.11.20.
//

import Foundation

enum AoENetError: Error {
    case message(String)
    case other(Error)
    
    static func map(_ error: Error) -> AoENetError {
      return (error as? AoENetError) ?? .other(error)
    }
}

extension AoENetError: CustomStringConvertible {
  var description: String {
    switch self {
    case .message(let message):
      return message
    case .other(let error):
      return error.localizedDescription
    }
  }
}
