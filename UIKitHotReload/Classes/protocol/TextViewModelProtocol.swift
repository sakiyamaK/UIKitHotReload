//
//  TextViewModelProtocol.swift
//  UIKitHotReload
//
//  Created by sakiyamaK on 2020/11/28.
//

import UIKit

public protocol TextViewModelProtocol: ViewModelProtocol, TextModelProtocol, TextInputTraitsModelProtocol {
  func setupTableView(_ tableView: UITableView)
}

public extension TextViewModelProtocol {
  func setupTextView(_ textView: UITextView) {
    textView.text = text
    textView.textContentType = textContentType
    textView.autocapitalizationType = capitalizationType
    textView.keyboardType = keyboardType
    textView.returnKeyType = returnKeyType
    textView.isSecureTextEntry = isSecureTextEntry
    textView.enablesReturnKeyAutomatically = enablesReturnKeyAutomatically
  }
}
