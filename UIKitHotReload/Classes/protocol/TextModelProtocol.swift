//
//  TextModelProtocol.swift
//  UIKitHotReload
//
//  Created by sakiyamaK on 2020/11/28.
//

import UIKit

public protocol TextModelProtocol {
  var text: String? { get }
  var _textColor: [CGFloat]?  { get }
  var _textAlignment: String? { get }
  var _fontInfo: FontInfoModel? { get }
}

public extension TextModelProtocol {
  var textColor: UIColor { _textColor?.uiColor ?? UIColor.darkText }
  var textAlignment: NSTextAlignment { _textAlignment?.textAlignment ?? .left }
  var font: UIFont? {  _fontInfo?.font }
}
