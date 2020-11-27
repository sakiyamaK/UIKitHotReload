//
//  TextViewModelProtocol.swift
//  UIKitHotReload
//
//  Created by sakiyamaK on 2020/11/28.
//

import UIKit

public protocol TextViewModelProtocol: ViewModelProtocol {
  var _separatorStyle: String? { get }
  var _sStyle: String? { get }
  var _indicatorStyle: String? { get }
  var _iStyle: String? { get }
  func setupTableView(_ tableView: UITableView)
}

public extension TextViewModelProtocol {
  func setupTextView(_ textView: UITextView) {
  }
}
