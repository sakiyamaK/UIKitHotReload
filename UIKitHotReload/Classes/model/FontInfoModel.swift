//
//  FontInfoViewModel.swift
//  SampleFirebase
//
//  Created by sakiyamaK on 2020/10/19.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import UIKit

public struct FontInfoModel: Decodable {
  public var name: String?
  private var _size: CGFloat?
  private var size: CGFloat { _size ?? 12 }
  private var _weight: String?
  public var weight: UIFont.Weight { (_weight ?? "").fontWeight }
  
  private enum CodingKeys: String, CodingKey {
    case
      name = "name",
      _size = "size",
      _weight = "weight"
  }
  
  public var font: UIFont? {
    var font: UIFont?
    if let name = name {
      font = UIFont.init(name: name, size: size)
    } else {
      font = UIFont.systemFont(ofSize: size, weight: weight)
    }
    return font
  }
}
