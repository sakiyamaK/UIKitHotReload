//
//  ViewModelType.swift
//  SampleFirebase
//
//  Created by sakiyamaK on 2020/10/12.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import UIKit

public enum ViewModelType: String {
  case uistackview, stackview, stack, vstack, hstack, component
  case uiview, view
  case uilabel, label
  case uiiamgeview, imageview

  public var view: UIView? {
    switch self {
    case .uistackview, .stackview, .stack:
      let scrollView = UIScrollView()
      let stackView = UIStackView()
      scrollView.addSubview(stackView)
      return scrollView
    case .uilabel, .label:
      return UILabel()
    case .uiiamgeview, .imageview:
      return UIImageView()
    case .component:
      return nil
    default:
      return UIView()
    }
  }
}
