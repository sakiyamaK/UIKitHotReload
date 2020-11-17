//
//  Array+.swift
//  SampleFirebase
//
//  Created by sakiyamaK on 2020/10/12.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import UIKit

public extension Array where Element: Numeric {
  var uiColor: UIColor? {
    guard
      let r = (self[0] as? CGFloat),
      let g = (self[1] as? CGFloat),
      let b = (self[2] as? CGFloat) else {
        return nil
    }
    let a = (self[safe: 3] as? CGFloat) ?? 1.0
    return UIColor(red: r, green: g, blue: b, alpha: a)
  }

  var cgPoint: CGPoint? {
    guard
      let x = (self[0] as? CGFloat),
      let y = (self[1] as? CGFloat) else {
      return nil
    }
    return CGPoint(x: x, y: y)
  }

  var size: CGSize? {
    guard
      let w = (self[0] as? CGFloat),
      let h = (self[1] as? CGFloat) else {
      return nil
    }
    return CGSize(width: w, height: h)
  }
}

public extension Array where Element: StringProtocol {
  var maskedCorners: CACornerMask {
    var maskedCorners: CACornerMask = CACornerMask.init()
    if self.contains("min_x_min_y") || self.contains("min_min") { maskedCorners = CACornerMask(rawValue: maskedCorners.rawValue + CACornerMask.layerMinXMinYCorner.rawValue) }
    if self.contains("min_x_max_y") || self.contains("min_max") { maskedCorners = CACornerMask(rawValue: maskedCorners.rawValue + CACornerMask.layerMinXMaxYCorner.rawValue) }
    if self.contains("max_x_min_y") || self.contains("max_min") { maskedCorners = CACornerMask(rawValue: maskedCorners.rawValue + CACornerMask.layerMaxXMinYCorner.rawValue) }
    if self.contains("max_x_max_y") || self.contains("max_max") { maskedCorners = CACornerMask(rawValue: maskedCorners.rawValue + CACornerMask.layerMaxXMaxYCorner.rawValue) }
    return maskedCorners
  }
}
