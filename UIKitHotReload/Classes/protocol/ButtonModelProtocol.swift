//
//  ButtomModelProtocol.swift
//  UIKitHotReload
//
//  Created by sakiyamaK on 2020/11/15.
//

import UIKit

public protocol ButtonModelProtocol: LabelModelProtocol {
  func setupButton(_ button: UIButton)
}

public extension ButtonModelProtocol {
  func setupButton(_ button: UIButton) {
    button.setTitle(text, for: .normal)
    button.setTitleColor(textColor ?? UIColor.systemBlue, for: .normal)
    if let _font = font {
      button.titleLabel?.font = _font
    }
    if let _textAlignment = textAlignment {
      button.titleLabel?.textAlignment = _textAlignment
    }
    if let _numberOfLines = numberOfLines {
      button.titleLabel?.numberOfLines = _numberOfLines
    }
  }
}
