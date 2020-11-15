//
//  LoginViewController.swift
//  UIKitHotReload_Example
//
//  Created by sakiyamaK on 2020/11/15.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import UIKitHotReload

final class LoginViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.loadHotReload(dirName: "views", jsonFileName: "login") { error in
      if let _error = error {
        print(_error.localizedDescription)
        return
      }
      self.setupAction()
    }
  }

  private func setupAction() {
    if let loginButton = self.view.hotReloadView(id: "login_button") as? UIButton {
      loginButton.addTarget(self, action: #selector(tapLogin), for: .touchUpInside)
    }
  }

  @objc func tapLogin() {
    print("ログイン")
  }
}
