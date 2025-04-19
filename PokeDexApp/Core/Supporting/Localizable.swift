//
//  Localizable.swift
//  PokeDexApp
//
//  Created by Felipe Giampaoli on 16/04/25.
//

import Foundation

protocol Localizable {
  var rawValue: String { get }
  var localized: String { get }
  func localized(with arguments: CVarArg...) -> String
}

extension Localizable {
  var localized: String {
    NSLocalizedString(rawValue, comment: "")
  }
  
  func localized(with arguments: CVarArg...) -> String {
    String(format: localized, arguments: arguments)
  }
}
