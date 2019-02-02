//
//  SourceEditorCommand.swift
//  SourceEditorExtension
//
//  Created by Steven on 12/1/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import AppKit
import XcodeKit

class OpenCommand: NSObject, XCSourceEditorCommand {

  func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) {
    defer { completionHandler(nil) }
    let lines = invocation.buffer.lines.compactMap { $0 as? String }
    let selectedRanges = invocation.buffer.selections.compactMap { $0 as? XCSourceTextRange }
    guard !lines.isEmpty, !selectedRanges.isEmpty else { return }

    var allSelectionsCode = ""
    for range in selectedRanges {
      var singleSelectionCode = ""
      let startLine = range.start.line
      let endLine = lines.endIndex == range.end.line ? range.end.line - 1 : range.end.line
      for lineIndex in startLine...endLine {
        let line = lines[lineIndex]
        let isFirstLine = lineIndex == startLine
        let isLastLine = lineIndex == endLine
        let startColumn = isFirstLine ? String.Index(encodedOffset: range.start.column) : line.startIndex
        let endColumn = isLastLine ? String.Index(encodedOffset: range.end.column) : line.endIndex

        let singleLineCode = String(line[startColumn..<endColumn])
        singleSelectionCode.append(singleLineCode)
      }
      allSelectionsCode.append(singleSelectionCode)
    }

    guard !allSelectionsCode.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
      let carbonNowDict = CarbonNow(
        code: allSelectionsCode,
        language: CodeLanguage(UTI: invocation.buffer.contentUTI),
        lineNumbers: prefs.object(forKey: lineNumbersPrefKey) as? Bool ?? false,
        windowControls: prefs.object(forKey: windowControlsPrefKey) as? Bool ?? true)
        .toDictionary() else { return }

    var query: [URLQueryItem] = []

    for param in carbonNowDict {
      let value: String
      if let bool = param.value as? Bool {
        value = bool.description
      } else {
         value = (param.value as? String) ?? ""
      }
      query.append(URLQueryItem(name: param.key, value: value))
    }
    let urlcomps = NSURLComponents(string: "https://carbon.now.sh")
    urlcomps?.queryItems = query
    NSWorkspace.shared.open(urlcomps!.url!)
  }
}

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
  case swift
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
