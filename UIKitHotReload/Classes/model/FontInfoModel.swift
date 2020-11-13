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
  public var size: CGFloat?

  public var font: UIFont? {
    var font: UIFont?
    if let name = name, let size = size {
      font = UIFont.init(name: name, size: size)
    } else if let name = name {
      font = UIFont.init(name: name, size: 12)
    } else if let size = size {
      font = UIFont.systemFont(ofSize: size)
    } else {
      font = UIFont()
    }

    return font
  }
}
