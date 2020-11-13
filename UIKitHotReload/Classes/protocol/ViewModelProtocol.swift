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
  var identifier: String? { get }
  var _backgroundColor: [CGFloat]?  { get }
  var backgroundColor: UIColor?  { get }
  var _contentMode: String? { get }
  var contentMode: UIView.ContentMode { get }
  var width: CGFloat? { get }
  var height: CGFloat? { get }
  var alpha: CGFloat? { get }
  var isHidden: Bool? { get }
  var edgePriority: EdgePriorityModel? { get }
  var _huggings: [HuggingModel]?  { get }
  var _compressionResistances: [CompressionResistanceModel]?  { get }
  var isSafeArea: Bool? { get }
  var view: UIView? { get }
  var _subviewProtocols: [Self]? { get }
  func setupView(_ view: UIView)
}

public extension ViewModelProtocol {
  var backgroundColor: UIColor? { _backgroundColor?.uiColor }

  var contentMode: UIView.ContentMode { (_contentMode ?? "").contentMode }

  var viewModelType: ViewModelType? { ViewModelType(rawValue: className?.lowercased() ?? "") }

  func setupView(_ view: UIView) {

    view.accessibilityIdentifier = identifier
    view.backgroundColor = backgroundColor
    view.contentMode = contentMode
    view.alpha = alpha ?? 1.0
    view.isHidden = isHidden ?? false

    for hugging in _huggings ?? [] {
      view.setContentHuggingPriority(hugging.priority, for: hugging.axis)
    }

    for compressionResistance in _compressionResistances ?? [] {
      view.setContentCompressionResistancePriority(compressionResistance.priority, for: compressionResistance.axis)
    }

    view.translatesAutoresizingMaskIntoConstraints = false
    if let _width = width {
      view.widthAnchor.constraint(equalToConstant: _width).isActive = true
    }
    if let _height = height {
      view.heightAnchor.constraint(equalToConstant: _height).isActive = true
    }

    if let _subviews = _subviewProtocols?.map({
      ($0.view, $0.edgePriority)
    }).filter({ $0.0 != nil }) as? [(UIView, EdgePriorityModel?)] {
      for (_subview, _edgePriority) in _subviews {
        if view is UIScrollView {
          (view.subviews.first as! UIStackView).addArrangedSubview(_subview)
        } else {
          view.addSubview(_subview)
          if let _priorities = _edgePriority?.priorities {
            _subview.edgesEqual(to: view, priorities: _priorities)
          }
        }
      }
    }
  }
}
