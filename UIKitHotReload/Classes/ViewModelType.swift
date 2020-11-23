//
//  ViewModelType.swift
//  SampleFirebase
//
//  Created by sakiyamaK on 2020/10/12.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import UIKit

public enum ViewModelType: String {
  case uistackview, stackview, stack
  case uilabel, label
  case uiiamgeview, imageview
  case uibutton, button
  case uiview, view
  case uitableview, tableview

  public var view: UIView? {
    switch self {
    case .uistackview, .stackview, .stack:
      let scrollView = UIScrollView()
      return scrollView
    case .uilabel, .label:
      return UILabel()
    case .uiiamgeview, .imageview:
      return UIImageView()
    case .uibutton, .button:
      return UIButton()
    case .uitableview, .tableview:
      return UITableView()
    default:
      return UIView()
    }
  }
}
