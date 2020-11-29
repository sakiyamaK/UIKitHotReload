//
//  TextFieldModelPorotocol.swift
//  UIKitHotReload
//
//  Created by sakiyamaK on 2020/11/28.
//

import UIKit

public protocol TextFieldModelProtocol: ViewModelProtocol, TextModelProtocol {
  var placeholder: String? { get }
  var _borderStyle: String? { get }
  var _textContentType: String? { get }
  var _capitalizationType: String? { get }
  var _capType: String? { get }
  var _keyboardType: String? { get }
  var _returnKeyType: String? { get }
  var _isSecureTextEntry: Bool? { get }
  var _secureTextEntry: Bool? { get }
  var _secure: Bool? { get }
  var _enablesReturnKeyAutomatically: Bool? { get }

  func setupTextField(_ textField: UITextField)
}

public extension TextFieldModelProtocol {

  var borderStyle: UITextField.BorderStyle { (_borderStyle ?? "").borderStyle }
  var textContentType: UITextContentType? { _textContentType?.textContentType }
  var capitalizationType: UITextAutocapitalizationType { [_capitalizationType, _capType].first {$0 != nil}??.capitalizationType ?? .none }
  var keyboardType: UIKeyboardType { (_keyboardType ?? "").keyboardType }
  var returnKeyType: UIReturnKeyType { (_returnKeyType ?? "").returnKeyType }
  var isSecureTextEntry: Bool {
    guard let isSecureTextEntry = ([_isSecureTextEntry, _secureTextEntry, _secure].first{$0 != nil}) else { return false }
    return isSecureTextEntry ?? false
  }
  var enablesReturnKeyAutomatically: Bool { _enablesReturnKeyAutomatically ?? false }

  func setupTextField(_ textField: UITextField) {
    textField.text = text
    textField.font = font
    textField.textColor = textColor
    textField.textAlignment = textAlignment
    textField.borderStyle = borderStyle
    textField.placeholder = placeholder
    textField.textContentType = textContentType
    textField.autocapitalizationType = capitalizationType
    textField.keyboardType = keyboardType
    textField.returnKeyType = returnKeyType
    textField.isSecureTextEntry = isSecureTextEntry
    textField.enablesReturnKeyAutomatically = enablesReturnKeyAutomatically
  }
}
