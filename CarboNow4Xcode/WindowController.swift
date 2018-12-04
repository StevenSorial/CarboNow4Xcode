//
//  WindowController.swift
//  carbon-now-sh
//
//  Created by Steven on 12/3/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController, NSWindowDelegate {
  func windowWillClose(_ notification: Notification) {
    NSApp.terminate(self)
  }
}
