//
//  ViewController.swift
//  UIKitHotReload
//
//  Created by sakiyama.k@gmail.com on 11/13/2020.
//  Copyright (c) 2020 sakiyama.k@gmail.com. All rights reserved.
//

import UIKit
import UIKitHotReload

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      self.view.loadHotReloadUI(collectionName: "views", documentName: "sample") { error in
        print(error?.localizedDescription)
      }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

