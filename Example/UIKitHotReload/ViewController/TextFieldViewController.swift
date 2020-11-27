//
//  TextFieldViewController.swift
//  UIKitHotReload_Example
//
//  Created by sakiyamaK on 2020/11/28.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import UIKitHotReload

final class TextFieldViewController: UIViewController {

  private var textField: UITextField? { self.view.hotReloadView(id: "text_field") as? UITextField }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.loadHotReload(dirName: "views", jsonFileName: "text_field") { result in
      switch result {
      case .failure(let error):
        print(error.localizedDescription)
      default:
        break
      }
    }
  }
}
