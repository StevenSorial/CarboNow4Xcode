//
//  CarbonNowModel.swift
//  CarboNow4Xcode
//
//  Created by Steven on 2/2/19.
//  Copyright © 2019 Steven. All rights reserved.
//

struct CarbonNow: Codable {
  let code: String
  let language: CodeLanguage
  let lineNumbers: Bool
  let windowControls: Bool

  enum CodingKeys: String, CodingKey {
    case code
    case language = "l"
    case lineNumbers = "ln"
    case windowControls = "wc"
  }
}

enum CodeLanguage: String, Codable, CaseIterable {
  case objectivec
  case javascript
  case htmlmixed
  case markdown
  case python
  case swift
  case perl
  case java
  case ruby
  case auto
  case xml
  case cpp
  case css
  // swiftlint:disable:next identifier_name
  case c

  init(UTI: String) {
    let UTI = UTI.lowercased().replacingOccurrences(of: "-", with: "")
    // swiftlint:disable:next first_where
    let lang = CodeLanguage.allCases.filter { $0 != .c }.first { UTI.contains( $0.rawValue) }
    if lang != nil { self = lang!
    } else if UTI.contains("html") { self = .htmlmixed
    } else if UTI.contains("cplusplus") { self = .cpp
    } else if UTI.contains("csource") || UTI.contains("cheader") { self = .c
    } else { self = .auto }
  }
}
