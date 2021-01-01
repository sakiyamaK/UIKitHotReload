//
//  AnimationViewController.swift
//  UIKitHotReload_Example
//
//  Created by sakiyamaK on 2020/12/31.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import UIKitHotReload

final class AnimationViewController: UIViewController {

  private var defLeftConstraint: NSLayoutConstraint? { self.view.hotReloadConstraint(id: "def_left_const") }
  private var defTopConstraint: NSLayoutConstraint? { self.view.hotReloadConstraint(id: "def_top_const") }
  private var defWidthConstraint: NSLayoutConstraint? { self.view.hotReloadConstraint(id: "def_width_const") }
  private var defHeightConstraint: NSLayoutConstraint? { self.view.hotReloadConstraint(id: "def_height_const") }
  private var defConstraints: [NSLayoutConstraint?] = []

  private var animationView: UIView? {self.view.hotReloadView(id: "animation_view")}

  private var isChanged: Bool = false

  override func viewDidLoad() {
    super.viewDidLoad()
    let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapView))
    self.view.loadHotReload(dirName: "views", ymlFileName: "animation") {[weak self] result in
      switch result {
      case .failure(let error):
        print(error.localizedDescription)
      default:
        guard let self = self else { return }
        self.isChanged = false
        self.defConstraints = [self.defLeftConstraint, self.defTopConstraint, self.defWidthConstraint, self.defHeightConstraint]

        self.animationView?.addGestureRecognizer(tap)
        self.animationView?.isUserInteractionEnabled = true

      }
    }
  }

  @objc private func tapView(_ view: UIView) {
    isChanged.toggle()
    let p = isChanged ? UILayoutPriority.defaultLow : UILayoutPriority.required
    defConstraints.filter {$0 != nil}.forEach {
      $0!.priority = p
    }

    UIView.animate(withDuration: 0.5) {
      self.view.layoutIfNeeded()
    }
  }
}
