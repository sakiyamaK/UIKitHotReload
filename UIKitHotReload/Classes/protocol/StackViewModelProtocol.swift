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
  var _spacing: CGFloat? { get }
  var _isScrollEnabled: Bool? { get }
  var _scrollEnabled: Bool? { get }
  var _isPagingEnabled: Bool? { get }
  var _pagingEnabled: Bool? { get }
  var _showsVerticalScrollIndicator: Bool? { get }
  var _vIndicator: Bool? { get }
  var _showsHorizontalScrollIndicator: Bool? { get }
  var _hIndicator: Bool? { get }
  var _contentInsets: EdgeInsetsModel? { get }
  var _contentOffset: CGPoint? { get }
  func setupScrollView(_ scrollView: UIScrollView)
}

public extension StackViewModelProtocol {

  var alignment: UIStackView.Alignment { (_alignment ?? "").alignment }
  var distribution: UIStackView.Distribution { (_distribution ?? "").distribution }
  var axis: NSLayoutConstraint.Axis { (_axis ?? "").axis }
  var spacing: CGFloat { _spacing ?? 0.0 }
  var isScrollEnabled: Bool { (_isScrollEnabled ?? true) && (_scrollEnabled ?? true) }
  var isPagingEnabled: Bool { (_isPagingEnabled ?? false) || (_pagingEnabled ?? false) }
  var showsVerticalScrollIndicator: Bool {
    (_showsVerticalScrollIndicator ?? true) && (_vIndicator ?? true)
  }
  var showsHorizontalScrollIndicator: Bool {
    (_showsHorizontalScrollIndicator ?? true) && (_hIndicator ?? true)
  }
  var contentInsets: UIEdgeInsets { (_contentInsets ?? EdgeInsetsModel()).edgeInsets }
  var contentOffset: CGPoint { _contentOffset ?? .zero }

  func setupScrollView(_ scrollView: UIScrollView) {
    guard let stackView = scrollView.subviews.first as? UIStackView else { return }
    scrollView.isScrollEnabled = isScrollEnabled
    scrollView.isPagingEnabled = isPagingEnabled
    scrollView.showsVerticalScrollIndicator = showsVerticalScrollIndicator
    scrollView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
    scrollView.contentInset = contentInsets
    scrollView.contentOffset = contentOffset

    setupStackView(stackView)
    stackView.edgesEqual(to: scrollView.contentLayoutGuide, priorities: edgePriority.priorities)
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
    stackView.spacing = spacing
  }
}
