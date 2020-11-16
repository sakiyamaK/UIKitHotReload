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

  private var buttons: UIButton? { self.view.hotReloadView(id: "to_buttons") as? UIButton }
  private var labels: UIButton? { self.view.hotReloadView(id: "to_labels") as? UIButton }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.loadHotReload(dirName: "views", jsonFileName: "main") { error in
      if let _error = error {
        print(_error.localizedDescription)
        return
      }
      self.setupAction()
    }
  }

  private func setupAction() {
    self.buttons?.addTarget(self, action: #selector(tapButtons), for: .touchUpInside)
    self.labels?.addTarget(self, action: #selector(tapLabels), for: .touchUpInside)
  }

  @objc func tapButtons() {
    Router.showButtons(from: self)
  }

  @objc func tapLabels() {
    Router.showLabels(from: self)
  }
}
