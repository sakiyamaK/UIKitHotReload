//
//  ImageViewController.swift
//  UIKitHotReload_Example
//
//  Created by sakiyamaK on 2020/11/18.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import UIKitHotReload

final class ImagesViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.loadHotReload(dirName: "views", jsonFileName: "images") { result in
      switch result {
      case .failure(let error):
        print(error.localizedDescription)
      default:
        break
      }
    }
  }
}
