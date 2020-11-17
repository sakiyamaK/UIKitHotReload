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
  var _textAlignment: String? { get }
  var _fontInfo: FontInfoModel? { get }
  var _numberOfLines: Int? { get }
  func setupLabel(_ label: UILabel)
}

public extension LabelModelProtocol {
  var textColor: UIColor { _textColor?.uiColor ?? UIColor.darkText }
  var textAlignment: NSTextAlignment { _textAlignment?.textAlignment ?? .left }
  var font: UIFont? {  _fontInfo?.font }
  var numberOfLines: Int { _numberOfLines ?? 1 }

  func setupLabel(_ label: UILabel) {
    label.text = text
    if let _font = font {
      label.font = _font
    }
    label.backgroundColor = backgroundColor
    label.textColor = textColor
    label.textAlignment = textAlignment
    label.numberOfLines = numberOfLines
  }
}
