//
//  BorderModel.swift
//  UIKitHotReload
//
//  Created by sakiyamaK on 2020/11/18.
//

import Foundation

public struct BorderModel: Decodable {
  private enum CodingKeys: String, CodingKey {
    case
      _color = "color",
      _width = "width"
  }
  private var _color: [CGFloat]?
  private var _width: CGFloat?

  public var color: UIColor { _color?.uiColor ?? .clear }
  public var width: CGFloat { _width ?? 0 }
}
