//
//  UIViewController+.swift
//  UIKitHotReload
//
//  Created by sakiyamaK on 2021/01/11.
//

import UIKit

public extension UIViewController {
  func add(content: UIViewController, container: UIView){
    addChild(content)
    content.view.frame = container.bounds
    container.addSubview(content.view)
    content.didMove(toParent: self)
  }

  func remove(content: UIViewController){
    content.willMove(toParent: self)
    content.view.removeFromSuperview()
    content.removeFromParent()
  }
}
