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
      _priority = "priority", _p = "p",
      _axis = "axis"
  }
  public var _priority: Float?
  public var _p: Float?
  public var _axis: String?

  public var axis: NSLayoutConstraint.Axis { (_axis ?? "").axis }

  public var priority: UILayoutPriority {
    let p = [_priority, _p].first{$0 != nil} as? Float ?? UILayoutPriority.defaultHigh.rawValue
    return UILayoutPriority(p)
  }
}
