//
//  HuggingModel.swift
//  SampleFirebase
//
//  Created by sakiyamaK on 2020/10/19.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import UIKit

public struct HuggingModel: Decodable {
  private enum CodingKeys: String, CodingKey {
    case
      _priority = "priority",
      _p = "p",
      _axis = "axis"
  }
  public var _priority: Float?
  public var _p: Float?
  public var _axis: String?

  public var axis: NSLayoutConstraint.Axis {
    guard
      let axisStr = _axis else {
      return "".axis
    }
    return axisStr.axis
  }

  public var priority: UILayoutPriority {
    if let priority = _priority {
      return UILayoutPriority(priority)
    }
    if let priority = _p {
      return UILayoutPriority(priority)
    }
    return .defaultHigh
  }
}
