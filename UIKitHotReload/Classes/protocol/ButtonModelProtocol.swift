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
    button.setTitleColor(textColor, for: .normal)
    button.titleLabel?.font = font
    button.titleLabel?.textAlignment = textAlignment
    button.titleLabel?.numberOfLines = numberOfLines ?? 1
  }
}
