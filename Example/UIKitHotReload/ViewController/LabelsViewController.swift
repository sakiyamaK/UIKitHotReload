//
//  LabelsViewController.swift
//  UIKitHotReload_Example
//
//  Created by sakiyamaK on 2020/11/16.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import UIKitHotReload

final class LabelsViewController: UIViewController {

  private var label1: UILabel? { self.view.hotReloadView(id: "label1") as? UILabel }
  private var label2: UILabel? { self.view.hotReloadView(id: "label2") as? UILabel }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.loadHotReload(dirName: "views", jsonFileName: "labels") { error in
      if let _error = error {
        print(_error.localizedDescription)
        return
      }
    }
  }
}
