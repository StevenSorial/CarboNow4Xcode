//
//  ViewController.swift
//  carbon-now-sh
//
//  Created by Steven on 12/1/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import AppKit

class PreferencesVC: NSViewController {

  var mainView: PreferencesView! {
    return view as? PreferencesView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view = PreferencesView(frame: self.view.frame)
    mainView.lineNumbersCheckBox.state =
      (UserDefaults.common.object(forKey: UserDefaults.Keys.lineNumbers) as? Bool ?? false) ? .on : .off
    mainView.windowControlsCheckBox.state =
      (UserDefaults.common.object(forKey: UserDefaults.Keys.windowControls) as? Bool ?? true) ? .on : .off
    mainView.lineNumbersCheckBox.target = self
    mainView.windowControlsCheckBox.target = self
    mainView.lineNumbersCheckBox.action = .preferenceChanged
    mainView.windowControlsCheckBox.action = .preferenceChanged
  }

  @objc
  func preferenceChanged() {
    UserDefaults.common.set(mainView.lineNumbersCheckBox.state == .on, forKey: UserDefaults.Keys.lineNumbers)
    UserDefaults.common.set(mainView.windowControlsCheckBox.state == .on, forKey: UserDefaults.Keys.windowControls)
  }
}

extension Selector {
  static let preferenceChanged = #selector(PreferencesVC.preferenceChanged)
}
