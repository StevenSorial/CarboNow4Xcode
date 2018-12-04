//
//  ViewController.swift
//  carbon-now-sh
//
//  Created by Steven on 12/1/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

  weak var lineNumbersCheckBox: NSButton!
  weak var windowControlsCheckBox: NSButton!
  weak var stackView: NSStackView!

  override func viewDidLoad() {
    super.viewDidLoad()
    let lineNumbersCheckBox = NSButton(checkboxWithTitle: "Line numbers",
                                       target: self,
                                       action: .preferenceChanged)
    lineNumbersCheckBox.allowsMixedState = false
    lineNumbersCheckBox.state = (prefs.object(forKey: lineNumbersPrefKey) as? Bool ?? false) ? .on : .off
    lineNumbersCheckBox.translatesAutoresizingMaskIntoConstraints = false
    let windowControlsCheckBox = NSButton(checkboxWithTitle: "Window Controls",
                                          target: self,
                                          action: .preferenceChanged)
    windowControlsCheckBox.allowsMixedState = false
    windowControlsCheckBox.state = (prefs.object(forKey: windowControlsPrefKey) as? Bool ?? true) ? .on : .off
    windowControlsCheckBox.translatesAutoresizingMaskIntoConstraints = false
    let stackView = NSStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.distribution = .fillEqually
    stackView.alignment = .leading
    stackView.spacing = 15
    stackView.orientation = .vertical
    stackView.addArrangedSubview(lineNumbersCheckBox)
    stackView.addArrangedSubview(windowControlsCheckBox)
    view.addSubview(stackView)
    NSLayoutConstraint.activate([
      stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      stackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 15),
      stackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: 15),
      stackView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 15),
      stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: 15)
    ])

    self.stackView = stackView
    self.lineNumbersCheckBox = lineNumbersCheckBox
    self.windowControlsCheckBox = windowControlsCheckBox
  }

  @objc
  func preferenceChanged() {
    prefs.set(lineNumbersCheckBox.state == .on, forKey: lineNumbersPrefKey)
    prefs.set(windowControlsCheckBox.state == .on, forKey: windowControlsPrefKey)
  }

}

extension Selector {
  static let preferenceChanged = #selector(ViewController.preferenceChanged)
}
