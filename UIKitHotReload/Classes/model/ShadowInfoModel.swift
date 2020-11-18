//
//  ShadowModel.swift
//  UIKitHotReload
//
//  Created by sakiyamaK on 2020/11/17.
//

import Foundation

public struct ShadowInfoModel: Decodable {
  private var _color: [CGFloat]?
  private var _opacity: Float?
  private var _radius: CGFloat?
  private var _offset: [CGFloat]?

  private enum CodingKeys: String, CodingKey {
    case
      _color = "color",
      _opacity = "opacity",
      _radius = "radius",
      _offset = "offset"
  }

  var color: UIColor { _color?.uiColor ?? .clear }
  var opacity: Float { _opacity ?? 0.0 }
  var radius: CGFloat { _radius ?? 0.0 }
  var offset: CGSize { _offset?.cgSize ?? .zero }
}
