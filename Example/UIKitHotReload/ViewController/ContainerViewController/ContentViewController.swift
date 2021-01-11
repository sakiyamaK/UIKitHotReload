//
//  ContainerViewController.swift
//  UIKitHotReload_Example
//
//  Created by sakiyamaK on 2021/01/11.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import UIKitHotReload

final class ContentViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.loadHotReload(dirName: "components", ymlFileName: "container_content") { result in
      switch result {
      case .failure(let error):
        print(error.localizedDescription)
      default:
        break
      }
    }
  }
}
