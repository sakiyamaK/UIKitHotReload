//
//  ActivityIndicatorViewModelProtocol.swift
//  UIKitHotReload
//
//  Created by sakiyamaK on 2021/01/02.
//

import UIKit

public protocol ActivityIndicatorViewModelProtocol: ViewModelProtocol {
  var _activityIndicatorStyle: String? { get }
  var _aiStyle: String? { get }
  var _activityIndicatorColor: [CGFloat]?  { get }
  var _aiColor: [CGFloat]?  { get }
  var _hidesWhenStopped: Bool? { get }
  var _hides_ws: Bool? { get }
  func setupActivityIndicatorView(_ activityIndicatorView: UIActivityIndicatorView)
}

public extension ActivityIndicatorViewModelProtocol {
  var style: UIActivityIndicatorView.Style? {
    ([_activityIndicatorStyle, _aiStyle].first(where: {$0 != nil}) as? String)?.activityIndicatorViewStyle
  }
  var color: UIColor? {
    ([_activityIndicatorColor, _aiColor].first(where: {$0 != nil}) as? [CGFloat])?.uiColor
  }
  var hidesWhenStopped: Bool? {
    [_hidesWhenStopped, _hides_ws].first(where: {$0 != nil}) as? Bool
  }

  func setupActivityIndicatorView(_ activityIndicatorView: UIActivityIndicatorView) {
    if let style = style {
      activityIndicatorView.style = style
    }
    if let color = color {
      activityIndicatorView.color = color
    }
    if let hidesWhenStopped = hidesWhenStopped {
      activityIndicatorView.hidesWhenStopped = hidesWhenStopped
    }
  }
}

