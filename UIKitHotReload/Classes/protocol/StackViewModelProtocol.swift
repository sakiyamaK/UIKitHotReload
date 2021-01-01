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
  var isScrollEnabled: Bool { [_isScrollEnabled, _scrollEnabled].first{$0 != nil} as? Bool ?? true }
  var isPagingEnabled: Bool { [_isPagingEnabled, _pagingEnabled].first{$0 != nil} as? Bool ?? false }
  var showsVerticalScrollIndicator: Bool {
    [_showsVerticalScrollIndicator, _vIndicator].first{$0 != nil} as? Bool ?? true
  }
  var showsHorizontalScrollIndicator: Bool {
    [_showsHorizontalScrollIndicator, _hIndicator].first{$0 != nil} as? Bool ?? true
  }
  var contentInsets: UIEdgeInsets { (_contentInsets ?? EdgeInsetsModel()).edgeInsets }
  var contentOffset: CGPoint { _contentOffset ?? .zero }

  func setupScrollView(_ scrollView: UIScrollView) {
    scrollView.isScrollEnabled = isScrollEnabled
    scrollView.isPagingEnabled = isPagingEnabled
    scrollView.showsVerticalScrollIndicator = showsVerticalScrollIndicator
    scrollView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
    scrollView.contentInset = contentInsets
    scrollView.contentOffset = contentOffset

    setupStackView(scrollView: scrollView)
  }

  private func setupStackView(scrollView: UIScrollView) {
    let stackView = UIStackView()
    scrollView.addSubview(stackView)

    stackView.alignment = alignment
    stackView.distribution = distribution
    stackView.axis = axis
    stackView.spacing = spacing

    for layout in layouts {
      stackView.edgesEqual(to: scrollView.contentLayoutGuide, margin: layout.margin, isReverseMargin: true)
      if !scrollView.isScrollEnabled {
        let widthConstant = (layout.margin?.leading?.value ?? 0) + (layout.margin?.trailing?.value ?? 0)
        let heightConstant = (layout.margin?.top?.value ?? 0) + (layout.margin?.bottom?.value ?? 0)
        stackView.widthEqual(to: scrollView.frameLayoutGuide, constant: -widthConstant)
        stackView.heightEqual(to: scrollView.frameLayoutGuide, constant: -heightConstant)
        return
      }

      if axis == .vertical {
        let constant = (layout.margin?.leading?.value ?? 0) + (layout.margin?.trailing?.value ?? 0)
        stackView.widthEqual(to: scrollView.frameLayoutGuide, constant: -constant)
      } else {
        let constant = (layout.margin?.top?.value ?? 0) + (layout.margin?.bottom?.value ?? 0)
        stackView.heightEqual(to: scrollView.frameLayoutGuide, constant: -constant)
      }
    }
  }
}
