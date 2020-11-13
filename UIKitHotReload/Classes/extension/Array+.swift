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
}
