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
    self.button1?.addTarget(self, action: #selector(tapButton1), for: .touchUpInside)
    self.button2?.addTarget(self, action: #selector(tapButton2), for: .touchUpInside)
  }

  @objc func tapButton1() {
    print("button1をタップしました")
  }

  @objc func tapButton2() {
    print("button2をタップしました")
  }

}
