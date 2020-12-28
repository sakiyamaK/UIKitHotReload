//
//  TextinputTraitsModelProtocol.swift
//  UIKitHotReload
//
//  Created by sakiyamaK on 2020/12/28.
//

import Foundation

public protocol TextInputTraitsModelProtocol {
  var _textContentType: String? { get }
  var _capitalizationType: String? { get }
  var _capType: String? { get }
  var _keyboardType: String? { get }
  var _returnKeyType: String? { get }
  var _isSecureTextEntry: Bool? { get }
  var _secureTextEntry: Bool? { get }
  var _secure: Bool? { get }
  var _enablesReturnKeyAutomatically: Bool? { get }
}

public extension TextInputTraitsModelProtocol {
  var textContentType: UITextContentType? { _textContentType?.textContentType }
  var capitalizationType: UITextAutocapitalizationType { [_capitalizationType, _capType].first {$0 != nil}??.capitalizationType ?? .none }
  var keyboardType: UIKeyboardType { (_keyboardType ?? "").keyboardType }
  var returnKeyType: UIReturnKeyType { (_returnKeyType ?? "").returnKeyType }
  var isSecureTextEntry: Bool {
    guard let isSecureTextEntry = ([_isSecureTextEntry, _secureTextEntry, _secure].first{$0 != nil}) else { return false }
    return isSecureTextEntry ?? false
  }
  var enablesReturnKeyAutomatically: Bool { _enablesReturnKeyAutomatically ?? false }
}
