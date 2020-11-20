//
//  CircleModel.swift
//  UIKitHotReload
//
//  Created by sakiyamaK on 2020/11/21.
//

import Foundation

public struct CircleModel: Decodable {
  private var _borderColor: [CGFloat]?
  private var _color: [CGFloat]?
  private var _borderWidth: CGFloat?
  private var _width: CGFloat?
  private var _radius: CGFloat?
  private var _rad: CGFloat?

  private enum CodingKeys: String, CodingKey {
    case
      _borderColor = "border_color",
      _color = "color",
      _width = "width",
      _radius = "radius",
      _rad = "rad"
  }

  var borderColor: UIColor { [_borderColor, _color].first{$0 != nil}??.uiColor ?? .clear }
  var borderWidth: CGFloat { [_borderWidth, _width].first{$0 != nil} as? CGFloat ?? 0 }
  var radius: CGFloat { [_radius, _rad].first{$0 != nil} as? CGFloat ?? 0.0 }
}
