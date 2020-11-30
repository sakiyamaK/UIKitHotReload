//
//  LabelModelProtocol.swift
//  SampleFirebase
//
//  Created by sakiyamaK on 2020/10/12.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import UIKit

public protocol LabelModelProtocol: ViewModelProtocol, TextModelProtocol {
  var _numberOfLines: Int? { get }
  func setupLabel(_ label: UILabel)
}

public extension LabelModelProtocol {
  var numberOfLines: Int { _numberOfLines ?? 1 }

  func setupLabel(_ label: UILabel) {
    label.text = text
    if let _font = font {
      label.font = _font
    }
    label.textColor = textColor
    label.textAlignment = textAlignment
    label.numberOfLines = numberOfLines
  }
}
