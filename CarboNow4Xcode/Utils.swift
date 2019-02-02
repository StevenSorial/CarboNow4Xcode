//
//  Utils.swift
//  carbon-now-sh
//
//  Created by Steven on 12/3/18.
//  Copyright © 2018 Steven. All rights reserved.
//
import Foundation

extension UserDefaults {

  static var common: UserDefaults {
    return UserDefaults(
      suiteName: "\(Bundle.main.object(forInfoDictionaryKey: "TeamIdentifierPrefix") as? String ?? "")CarboNow4Xcode")!
  }

  enum Keys {
    static let windowControls = "windowControls"
    static let lineNumbers = "lineNumbers"
  }
}

extension Encodable {
  func toDictionary() -> [String: Any]? {
    guard let data = try? JSONEncoder().encode(self),
      let dictionary = try? JSONSerialization
        .jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
          return nil
    }
    return dictionary
  }
}
