//
//  TextFieldModelPorotocol.swift
//  UIKitHotReload
//
//  Created by sakiyamaK on 2020/11/28.
//

import UIKit

public protocol TextFieldModelProtocol: ViewModelProtocol, TextModelProtocol {
  var _borderStyle: String? { get }
  func setupTextField(_ textField: UITextField)
}

public extension TextFieldModelProtocol {

  var borderStyle: UITextField.BorderStyle { (_borderStyle ?? "").borderStyle }

  func setupTextField(_ textField: UITextField) {
    textField.text = text
    textField.font = font
    textField.textColor = textColor
    textField.textAlignment = textAlignment
    textField.borderStyle = borderStyle
  }
}
