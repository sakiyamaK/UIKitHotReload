//
//  StackViewModelProtocol.swift
//  SampleFirebase
//
//  Created by sakiyamaK on 2020/10/12.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import UIKit

public protocol StackViewModelProtocol: ViewModelProtocol {
  var _alignment: String? { get }
  var _distribution: String? { get }
  var _axis: String? { get }
  var isScrollEnabled: Bool? { get }
  var alignment: UIStackView.Alignment { get }
  var distribution: UIStackView.Distribution { get }
  var axis: NSLayoutConstraint.Axis { get }
  func setupScrollView(_ scrollView: UIScrollView)
}

public extension StackViewModelProtocol {

  var alignment: UIStackView.Alignment { (_alignment ?? "").alignment }
  var distribution: UIStackView.Distribution { (_distribution ?? "").distribution }
  var axis: NSLayoutConstraint.Axis { (_axis ?? "").axis }

  func setupScrollView(_ scrollView: UIScrollView) {
    guard let stackView = scrollView.subviews.first as? UIStackView else { return }
    scrollView.isScrollEnabled = isScrollEnabled ?? true
    setupStackView(stackView)
    stackView.edgesEqual(to: scrollView.contentLayoutGuide,
                         priorities: edgePriority?.priorities ?? UIEdgePriorities.init())
    if !scrollView.isScrollEnabled {
      stackView.widthEqual(to: scrollView.frameLayoutGuide)
      stackView.heightEqual(to: scrollView.frameLayoutGuide)
      return
    }

    if axis == .vertical {
      stackView.widthEqual(to: scrollView.frameLayoutGuide)
    } else {
      stackView.heightEqual(to: scrollView.frameLayoutGuide)
    }
  }

  private func setupStackView(_ stackView: UIStackView) {
    stackView.alignment = alignment
    stackView.distribution = distribution
    stackView.axis = axis
  }
}
