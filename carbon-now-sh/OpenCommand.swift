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
    var lastSelectionLineIndex: Int?
    for range in selectedRanges {
      var singleSelectionCode = ""

      if !allSelectionsCode.isEmpty && allSelectionsCode.suffix(
        from: allSelectionsCode.index(
          allSelectionsCode.endIndex,
          offsetBy: -1)
        ) != "\n" {
        singleSelectionCode = lastSelectionLineIndex == range.end.line ? " " : "\n"
      }

      let startLine = range.start.line
      let endLine = lines.endIndex == range.end.line ? range.end.line - 1 : range.end.line
      for lineIndex in startLine...endLine {
        let line = lines[lineIndex]
        let isFirstLine = lineIndex == startLine
        let isLastLine = lineIndex == endLine
        let startColumn = isFirstLine ? String.Index(utf16Offset: range.start.column, in: line) : line.startIndex
        let endColumn = isLastLine ? String.Index(utf16Offset: range.end.column, in: line) : line.endIndex

        let singleLineCode = String(line[startColumn..<endColumn])
        singleSelectionCode.append(singleLineCode)
      }
      allSelectionsCode.append(singleSelectionCode)
      lastSelectionLineIndex = range.end.line
    }

    guard !allSelectionsCode.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
    let carbonObject = CarbonNow(
      code: allSelectionsCode,
      language: CodeLanguage(UTI: invocation.buffer.contentUTI),
      lineNumbers: UserDefaults.common.object(forKey: UserDefaults.Keys.lineNumbers) as? Bool ?? false,
      windowControls: UserDefaults.common.object(forKey: UserDefaults.Keys.windowControls) as? Bool ?? true
    )

    openCarbon(with: carbonObject)

  }

  func openCarbon(with carbonObject: CarbonNow) {
    guard let carbonNowDict = carbonObject.toDictionary() else { return }

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
