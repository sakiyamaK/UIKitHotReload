//
//  Numeric+.swift
//  UIKitHotReload
//
//  Created by sakiyamaK on 2020/11/18.
//

import UIKit

public extension Float {
  var toCGFloat: CGFloat { CGFloat(self) }
}
public extension CGFloat {
  var toFloat: Float { Float(self) }
}
