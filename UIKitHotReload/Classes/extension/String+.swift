//
//  String+.swift
//  SampleFirebase
//
//  Created by sakiyamaK on 2020/10/12.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import UIKit

public extension String {
  var contentMode: UIView.ContentMode {
    switch self.lowercased() {
    case "scaleaspectfill", "aspectfill", "scale_aspect_fill", "aspect_fill", "fill":
      return .scaleAspectFill
    case "scaleaspectfit", "aspectfit", "scale_aspect_fit", "aspect_fit", "fit":
      return .scaleAspectFit
    default:
      return .scaleToFill
    }
  }

  var axis: NSLayoutConstraint.Axis {
    switch self.lowercased() {
    case "vertial", "v":
      return NSLayoutConstraint.Axis.vertical
    case "horizontal", "h":
      return NSLayoutConstraint.Axis.horizontal
    default:
      return NSLayoutConstraint.Axis.vertical
    }
  }

  var alignment: UIStackView.Alignment {
    switch self.lowercased() {
    case "fill":
      return UIStackView.Alignment.fill
    case "center":
      return UIStackView.Alignment.center
    case "leading":
      return UIStackView.Alignment.leading
    case "trailing":
      return UIStackView.Alignment.trailing
    case "top":
      return UIStackView.Alignment.top
    case "bottom":
      return UIStackView.Alignment.bottom
    default:
      return UIStackView.Alignment.fill
    }
  }

  var distribution: UIStackView.Distribution {
    switch self.lowercased() {
    case "equalcentering", "equal_centering", "centering":
      return UIStackView.Distribution.equalCentering
    case "equalspacing", "equal_spacing", "spacing":
      return UIStackView.Distribution.equalSpacing
    case "fill":
      return UIStackView.Distribution.fill
    case "fillequally", "fill_equally", "fille", "fill_e":
      return UIStackView.Distribution.fillEqually
    case "fillproportionally", "fill_proportionally", "fillp", "fill_p":
      return UIStackView.Distribution.fillProportionally
    default:
      return UIStackView.Distribution.fill
    }
  }

  var textAlignment: NSTextAlignment {
    switch self.lowercased() {
    case "center":
      return .center
    case "right":
      return .right
    default:
      return .left
    }
  }

  var viewPath: (dirName: String, jsonFileName: String)? {
    let strs = self.components(separatedBy: "/")
    guard strs.count == 2 else { return nil }
    return (strs[0], strs[1])
  }
}
