//
//  LoginViewController.swift
//  UIKitHotReload_Example
//
//  Created by sakiyamaK on 2020/11/15.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import UIKitHotReload

final class ButtonsViewController: UIViewController {

  private var button1: UIButton? { self.view.hotReloadView(id: "button1") as? UIButton }
  private var button2: UIButton? { self.view.hotReloadView(id: "button2") as? UIButton }
  private var button3: UIButton? { self.view.hotReloadView(id: "button3") as? UIButton }
  private var button4: UIButton? { self.view.hotReloadView(id: "button4") as? UIButton }
  private var button5: UIButton? { self.view.hotReloadView(id: "button5") as? UIButton }
  private var buttons: [UIButton?] { [button1, button2, button3, button4, button5] }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.loadHotReload(dirName: "views", jsonFileName: "buttons") { error in
      if let _error = error {
        print(_error.localizedDescription)
        return
      }
      self.setupAction()
    }
  }

  @objc func tapButton(_ sender: UIButton) {
    Router.showAlert(message: "\(sender.titleLabel!.text!)をタップしました", vc: self)
  }
}

private extension ButtonsViewController {
  func setupAction() {
    buttons.forEach { $0?.addTarget(self, action: #selector(tapButton), for: .touchUpInside) }
  }
}
