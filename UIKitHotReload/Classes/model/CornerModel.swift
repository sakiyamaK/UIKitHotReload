//
//  CornerModel.swift
//  UIKitHotReload
//
//  Created by sakiyamaK on 2020/11/18.
//

import Foundation

public struct CornerModel: Decodable {
  private enum CodingKeys: String, CodingKey {
    case
      _masks = "masks",
      _radius = "radius", _rad = "rad"
  }
  private var _masks: [String]?
  private var _radius: CGFloat?
  private var _rad: CGFloat?

  public var maskedCorners: CACornerMask { (_masks ?? []).maskedCorners }
  public var radius: CGFloat { [_radius, _rad].first{$0 != nil} as? CGFloat ?? 0 }
}
