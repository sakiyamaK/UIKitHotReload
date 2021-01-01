//
//  MainViewController.swift
//  UIKitHotReload_Example
//
//  Created by sakiyamaK on 2020/11/16.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import UIKitHotReload

final class MainViewController: UIViewController {

  private var views: UIButton? { self.view.hotReloadView(id: "to_views") as? UIButton }
  private var buttons: UIButton? { self.view.hotReloadView(id: "to_buttons") as? UIButton }
  private var labels: UIButton? { self.view.hotReloadView(id: "to_labels") as? UIButton }
  private var images: UIButton? { self.view.hotReloadView(id: "to_images") as? UIButton }
  private var table: UIButton? { self.view.hotReloadView(id: "to_table") as? UIButton }
  private var textField: UIButton? { self.view.hotReloadView(id: "to_text_fields") as? UIButton }
  private var webview: UIButton? { self.view.hotReloadView(id: "to_webview") as? UIButton }
  private var twitter: UIButton? { self.view.hotReloadView(id: "to_twitter") as? UIButton }
  private var animation: UIButton? { self.view.hotReloadView(id: "to_animation") as? UIButton }
  private var toButtons: [UIButton?] { [views, buttons, labels, images, table, textField, webview, twitter, animation] }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.loadHotReload(dirName: "views", jsonFileName: "main") { result in
      switch result {
      case .failure(let error):
        print(error.localizedDescription)
      default:
        self.setupAction()
      }
    }
  }

  @objc func tapButton(_ sender: UIButton) {
    switch sender {
    case views:
      Router.showViews(from: self)
    case labels:
      Router.showLabels(from: self)
    case buttons:
      Router.showButtons(from: self)
    case images:
      Router.showImages(from: self)
    case textField:
      Router.showTextFields(from: self)
    case table:
      Router.showTable(from: self)
    case webview:
      Router.showWebView(from: self)
    case twitter:
      Router.showTwitter(from: self)
    case animation:
      Router.showAnimation(from: self)
    default:
      break
    }
  }
}

private extension MainViewController {
  func setupAction() {
    toButtons.forEach { $0?.addTarget(self, action: #selector(tapButton), for: .touchUpInside) }
  }
}
