//
//  BaseViewController.swift
//  UIKitHotReload_Example
//
//  Created by sakiyamaK on 2021/01/11.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import UIKitHotReload

final class BaseViewController: UIViewController {

  private var containerView: UIView? { self.view.hotReloadView(id: "container_view") }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.loadHotReload(dirName: "views", ymlFileName: "container_base") {[unowned self] result in
      switch result {
      case .failure(let error):
        print(error.localizedDescription)
      default:
        guard let containerView = self.containerView else { return }
        let vc = ContentViewController()
        self.add(content: vc, container: containerView)
      }
    }
  }
}
