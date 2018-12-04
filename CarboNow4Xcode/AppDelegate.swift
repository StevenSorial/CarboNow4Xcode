//
//  AppDelegate.swift
//  carbon-now-sh
//
//  Created by Steven on 12/1/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    NSApp.activate(ignoringOtherApps: true)
  }

  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }

}
