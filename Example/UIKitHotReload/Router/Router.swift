//
//  Router.swift
//  UIKitHotReload_Example
//
//  Created by sakiyamaK on 2020/11/16.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

final class Router {

  static func showViews(from: UIViewController, animated: Bool = true) {
    let to = ViewsViewController()
    show(from: from, to: to, animated: animated)
  }

  static func showLabels(from: UIViewController, animated: Bool = true) {
    let to = LabelsViewController()
    show(from: from, to: to, animated: animated)
  }

  static func showButtons(from: UIViewController, animated: Bool = true) {
    let to = ButtonsViewController()
    show(from: from, to: to, animated: animated)
  }

  static func showImages(from: UIViewController, animated: Bool = true) {
    let to = ImagesViewController()
    show(from: from, to: to, animated: animated)
  }

  static func showTextFields(from: UIViewController, animated: Bool = true) {
    let to = TextFieldsViewController()
    show(from: from, to: to, animated: animated)
  }

  static func showTable(from: UIViewController, animated: Bool = true) {
    let to = TableViewController()
    show(from: from, to: to, animated: animated)
  }

  static func showWebView(from: UIViewController, animated: Bool = true) {
    let to = WebViewController()
    show(from: from, to: to, animated: animated)
  }

  static func showTwitter(from: UIViewController, animated: Bool = true) {
    let to = TwitterTimelineViewController()
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

extension Router {
  static func showAlert(message: String, vc: UIViewController) {
    let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK",
                               style: .default,
                               handler: nil)
    alert.addAction(action)
    vc.present(alert, animated: true, completion: nil)
  }

}
