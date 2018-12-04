//
//  Utils.swift
//  carbon-now-sh
//
//  Created by Steven on 12/3/18.
//  Copyright © 2018 Steven. All rights reserved.
//
import Foundation

var prefs: UserDefaults {
  return UserDefaults(
    suiteName: "\(Bundle.main.object(forInfoDictionaryKey: "TeamIdentifierPrefix") as? String ?? "")CarboNow4Xcode")!
}

let windowControlsPrefKey = "windowControls"
let lineNumbersPrefKey = "windowControls"

extension Encodable {
  func toDictionary() -> [String: Any]? {
    guard let data = try? JSONEncoder().encode(self),
      let dictionary = try? JSONSerialization
        .jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
          return nil
    }
    return dictionary ?? nil
  }
}

extension Decodable {
  init?(dict: [String: Any]) {
    guard let dictData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted),
      let decoded = try? JSONDecoder().decode(Self.self, from: dictData) else {
        return nil
    }
    self = decoded
  }
}
