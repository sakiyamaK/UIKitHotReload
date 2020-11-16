//
//  LabelModelProtocol.swift
//  SampleFirebase
//
//  Created by sakiyamaK on 2020/10/12.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import UIKit

public protocol LabelModelProtocol: ViewModelProtocol {
  var text: String? { get }
  var _textColor: [CGFloat]?  { get }
  var textColor: UIColor?  { get }
  var _textAlignment: String? { get }
  var textAlignment: NSTextAlignment? { get }
  var _fontInfo: FontInfoModel? { get }
  var font: UIFont? { get }
  var numberOfLines: Int? { get }
  func setupLabel(_ label: UILabel)
}

public extension LabelModelProtocol {
  var textColor: UIColor? { _textColor?.uiColor }
  var textAlignment: NSTextAlignment? {  _textAlignment?.textAlignment }
  var font: UIFont? {  _fontInfo?.font }

  func setupLabel(_ label: UILabel) {
    label.text = text
    if let _font = font {
      label.font = _font
    }

    label.textColor = textColor ?? UIColor.darkText
    label.backgroundColor = backgroundColor ?? .clear

    if let _textAlignment = textAlignment {
      label.textAlignment = _textAlignment
    }
    if let _numberOfLines = numberOfLines {
      label.numberOfLines = _numberOfLines
    }
  }
}
