//
//  View.swift
//  CarboNow4Xcode
//
//  Created by Steven on 12/8/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import AppKit

class PreferencesView: NSView {

  weak var lineNumbersCheckBox: NSButton!
  weak var windowControlsCheckBox: NSButton!
  weak var stackView: NSStackView!

  override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)
    let lineNumbersCheckBox = NSButton(checkboxWithTitle: "Line numbers", target: nil, action: nil)
    lineNumbersCheckBox.allowsMixedState = false
    lineNumbersCheckBox.translatesAutoresizingMaskIntoConstraints = false
    let windowControlsCheckBox = NSButton(checkboxWithTitle: "Window Controls", target: nil, action: nil)
    windowControlsCheckBox.allowsMixedState = false
    windowControlsCheckBox.translatesAutoresizingMaskIntoConstraints = false
    let stackView = NSStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.distribution = .fillEqually
    stackView.alignment = .leading
    stackView.spacing = 15
    stackView.orientation = .vertical
    stackView.addArrangedSubview(lineNumbersCheckBox)
    stackView.addArrangedSubview(windowControlsCheckBox)
    addSubview(stackView)
    NSLayoutConstraint.activate([
      stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
      stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
      stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 50),
      stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: 50),
      stackView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 50),
      stackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: 50)
    ])
    self.stackView = stackView
    self.lineNumbersCheckBox = lineNumbersCheckBox
    self.windowControlsCheckBox = windowControlsCheckBox
  }

  required init?(coder decoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
