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

  private func setupAction() {
    self.button1?.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    self.button2?.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
  }

  @objc func tapButton(_ sender: UIButton) {
    switch sender {
    case button1:
      showAlert(message: "button1をタップしました")
    case button2:
      showAlert(message: "button2をタップしました")
    default:
      break
    }
  }

  private func showAlert(message: String) {
    let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK",
                               style: .default,
                               handler:nil)
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
}
