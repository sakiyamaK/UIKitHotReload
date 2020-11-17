//
//  ViewsViewController.swift
//  UIKitHotReload_Example
//
//  Created by sakiyamaK on 2020/11/17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import UIKitHotReload

final class ViewsViewController: UIViewController {

  private var view1: UIView? { self.view.hotReloadView(id: "view1") as? UILabel }
  private var view2: UIView? { self.view.hotReloadView(id: "view2") as? UILabel }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.loadHotReload(dirName: "views", jsonFileName: "views") { error in
      if let _error = error {
        print(_error.localizedDescription)
        return
      }
    }
  }
}
