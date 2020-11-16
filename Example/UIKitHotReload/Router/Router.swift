//
//  Router.swift
//  UIKitHotReload_Example
//
//  Created by sakiyamaK on 2020/11/16.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

final class Router {

  static func showButtons(from: UIViewController, animated: Bool = true) {
    let to = ButtonsViewController()
    show(from: from, to: to, animated: animated)
  }

  static func showLabels(from: UIViewController, animated: Bool = true) {
    let to = LabelsViewController()
    show(from: from, to: to, animated: animated)
  }

  private static func show(from: UIViewController, to: UIViewController, animated: Bool = true) {
    if let navigationController = from.navigationController {
      navigationController.pushViewController(to, animated: animated)
    } else {
      from.show(to, sender: nil)
    }
  }
}
