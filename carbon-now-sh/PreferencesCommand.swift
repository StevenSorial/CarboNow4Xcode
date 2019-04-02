//
//  PreferencesCommand.swift
//  Extension
//
//  Created by Steven on 12/4/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import XcodeKit
import AppKit

class PreferencesCommand: NSObject, XCSourceEditorCommand {

  func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) {
    NSWorkspace.shared.launchApplication(
      withBundleIdentifier: "com.stevenmagdy.CarboNow4Xcode",
      options: .default,
      additionalEventParamDescriptor: nil,
      launchIdentifier: nil)
    completionHandler(nil)
  }
}
