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
  var textColor: UIColor { _textColor?.uiColor ?? UIColor.systemBlue }
  var textAlignment: NSTextAlignment {  _textAlignment?.textAlignment ?? .center }
  var font: UIFont? {  _fontInfo?.font }
  var numberOfLines: Int { _numberOfLines ?? 1 }

  func setupButton(_ button: UIButton) {
    button.setTitle(text, for: .normal)
    button.setTitleColor(textColor, for: .normal)
    if let _font = font {
      button.titleLabel?.font = _font
    }
    button.titleLabel?.textAlignment = textAlignment
    button.titleLabel?.numberOfLines = numberOfLines
  }
}
