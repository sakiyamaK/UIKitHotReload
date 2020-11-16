//
//  PropertyModel.swift
//  SampleFirebase
//
//  Created by sakiyamaK on 2020/10/19.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import UIKit

public struct UIEdgePriorities {
  public var top: UILayoutPriority = .required
  public var leading: UILayoutPriority = .required
  public var trailing: UILayoutPriority = .required
  public var bottom: UILayoutPriority = .required

  public init() { }
}

public struct EdgePriorityModel: Decodable {
  private var top: Float?
  private var leading: Float?
  private var bottom: Float?
  private var trailing: Float?

  public var priorities: UIEdgePriorities {
    var p = UIEdgePriorities()
    p.top = UILayoutPriority.init(rawValue: top ?? UILayoutPriority.required.rawValue)
    p.leading = UILayoutPriority.init(rawValue: leading ?? UILayoutPriority.required.rawValue)
    p.bottom = UILayoutPriority.init(rawValue: bottom ?? UILayoutPriority.required.rawValue)
    p.trailing = UILayoutPriority.init(rawValue: trailing ?? UILayoutPriority.required.rawValue)
    return p
  }
}
