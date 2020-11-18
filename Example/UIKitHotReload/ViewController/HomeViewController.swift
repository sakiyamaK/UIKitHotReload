//
//  ViewController.swift
//  UIKitHotReload
//
//  Created by sakiyama.k@gmail.com on 11/13/2020.
//  Copyright (c) 2020 sakiyama.k@gmail.com. All rights reserved.
//

import UIKit
import UIKitHotReload

final class HomeViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.loadHotReload(dirName: "views", jsonFileName: "login") { result in
      switch result {
      case .failure(let error):
        print(error.localizedDescription)
      default:
        break
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

