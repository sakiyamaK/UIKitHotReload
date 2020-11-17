//
//  ViewModelProtocol.swift
//  SampleFirebase
//
//  Created by sakiyamaK on 2020/10/12.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import UIKit
import FirebaseFirestore

public protocol ViewModelProtocol {
  var className: String? { get }
  var id: String? { get }
  var width: CGFloat? { get }
  var height: CGFloat? { get }
  var view: UIView? { get }

  var _backgroundColor: [CGFloat]?  { get }
  var _contentMode: String? { get }
  var _alpha: CGFloat? { get }
  var _isHidden: Bool? { get }
  var _hidden: Bool? { get }
  var _edgePriority: EdgePriorityModel? { get }
  var _edgeInsets: EdgeInsetsModel? { get }
  var _huggings: [HuggingModel]?  { get }
  var _compressionResistances: [CompressionResistanceModel]?  { get }
  var _isSafeArea: Bool? { get }
  var _safeArea: Bool? { get }
  var _subviewProtocols: [Self]? { get }
  var _cornerRadius: CGFloat? { get }
  var _masksToBounds: Bool? { get }
  var _maskedCorners: [String]? { get }

  func setupView(_ view: UIView)
}

public extension ViewModelProtocol {
  var backgroundColor: UIColor { _backgroundColor?.uiColor ?? .clear }
  var contentMode: UIView.ContentMode { (_contentMode ?? "").contentMode }
  var viewModelType: ViewModelType? { ViewModelType(rawValue: className?.lowercased() ?? "") }
  var edgePriority: EdgePriorityModel { _edgePriority ?? EdgePriorityModel() }
  var edgeInsets: EdgeInsetsModel { _edgeInsets ?? EdgeInsetsModel() }
  var huggings: [HuggingModel] { _huggings ?? [] }
  var compressionResistances: [CompressionResistanceModel]  { _compressionResistances ?? [] }
  var isSafeArea: Bool { (_isSafeArea ?? true) && (_safeArea ?? true) }
  var alpha: CGFloat { _alpha ?? 1.0 }
  var isHidden: Bool { (_isHidden ?? false) || (_hidden ?? false) }
  var cornerRadius: CGFloat { _cornerRadius ?? 0.0 }
  var masksToBounds: Bool { _masksToBounds ?? false }
  var maskedCorners: CACornerMask? { _maskedCorners?.maskedCorners }

  func setupView(_ view: UIView) {

    view.accessibilityIdentifier = id
    view.backgroundColor = backgroundColor
    view.contentMode = contentMode
    view.alpha = alpha
    view.isHidden = isHidden
    view.layer.cornerRadius = cornerRadius
    view.layer.masksToBounds = masksToBounds
    if let maskedCorners = maskedCorners {
      view.layer.maskedCorners = maskedCorners
    }

    print(_masksToBounds)
    print(masksToBounds)

    for hugging in huggings {
      view.setContentHuggingPriority(hugging.priority, for: hugging.axis)
    }

    for compressionResistance in compressionResistances {
      view.setContentCompressionResistancePriority(compressionResistance.priority, for: compressionResistance.axis)
    }

    view.translatesAutoresizingMaskIntoConstraints = false
    if let _width = width {
      view.widthAnchor.constraint(equalToConstant: _width).isActive = true
    }
    if let _height = height {
      view.heightAnchor.constraint(equalToConstant: _height).isActive = true
    }

    _subviewProtocols?.filter({ $0.view != nil }).forEach({ (viewModel) in
      let subview = viewModel.view!
      if view is UIScrollView {
        (view.subviews.first as! UIStackView).addArrangedSubview(subview)
      } else {
        view.addSubview(subview)
        if viewModel.isSafeArea {
          subview.edgesEqualToSafeArea(view,
                                       margin: viewModel.edgeInsets.edgeInsets,
                                       priorities: viewModel.edgePriority.priorities)
        } else {
          subview.edgesEqual(to: view,
                             margin: viewModel.edgeInsets.edgeInsets,
                             priorities: viewModel.edgePriority.priorities)
        }
      }
    })
  }
}
