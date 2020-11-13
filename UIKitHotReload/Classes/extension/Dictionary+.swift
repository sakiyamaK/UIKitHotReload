//
//  Dictionary+.swift
//  SampleFirebase
//
//  Created by sakiyamaK on 2020/10/12.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import UIKit

public extension Dictionary where Key == String, Value == Any {
  var axis: NSLayoutConstraint.Axis {
    guard
      let axisStr = self["axis"] as? String else {
        return "".axis
    }
    return axisStr.axis
  }

  var priority: UILayoutPriority? {
    if let priority = self["priority"] as? Float {
      return UILayoutPriority(priority)
    }
    if let priority = self["p"] as? Float {
      return UILayoutPriority(priority)
    }
    return nil
  }
}
