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
  var _layout: LayoutModel? { get }
  var _huggings: [HuggingModel]?  { get }
  var _compressionResistances: [CompressionResistanceModel]?  { get }
  var _isSafeArea: Bool? { get }
  var _safeArea: Bool? { get }
  var _corner: CornerModel? { get }
  var _border: BorderModel? { get }
  var _shadow: ShadowInfoModel? { get }
  var _tintColor: [CGFloat]?  { get }
  var _clipToBounds: Bool? { get }
  var _clip: Bool? { get }
  var _subviewProtocols: [Self]? { get }

  func setupView(_ view: UIView)
}

public extension ViewModelProtocol {
  var backgroundColor: UIColor { _backgroundColor?.uiColor ?? .clear }
  var contentMode: UIView.ContentMode { (_contentMode ?? "").contentMode }
  var viewModelType: ViewModelType? { ViewModelType(rawValue: className?.lowercased() ?? "") }
  var layout: LayoutModel { _layout ?? LayoutModel() }
  var huggings: [HuggingModel] { _huggings ?? [] }
  var compressionResistances: [CompressionResistanceModel]  { _compressionResistances ?? [] }
  var isSafeArea: Bool { [_isSafeArea, _safeArea].first{$0 == true} as? Bool ?? false }
  var alpha: CGFloat { _alpha ?? 1.0 }
  var isHidden: Bool { [_isHidden, _hidden].first{$0 == true} as? Bool ?? false }
  var tintColor: UIColor { _tintColor?.uiColor ?? UIColor.clear }
  var clipToBounds: Bool { [_clipToBounds, _clip].first{$0 != nil} as? Bool ?? false }
  var corner: CornerModel { _corner ?? CornerModel() }
  var border: BorderModel { _border ?? BorderModel() }
  var shadow: ShadowInfoModel { _shadow ?? ShadowInfoModel() }

  func setupView(_ view: UIView) {

    view.accessibilityIdentifier = id
    view.backgroundColor = backgroundColor
    view.contentMode = contentMode
    view.alpha = alpha
    view.isHidden = isHidden
    view.tintColor = tintColor
    view.clipsToBounds = clipToBounds
    view.layer.cornerRadius = corner.radius
    view.layer.maskedCorners = corner.maskedCorners
    view.layer.borderWidth = border.width
    view.layer.borderColor = border.color.cgColor
    view.layer.shadowOpacity = shadow.opacity
    view.layer.shadowRadius = shadow.radius
    view.layer.shadowOffset = shadow.offset
    view.layer.shadowColor = shadow.color.cgColor

    for hugging in huggings {
      view.setContentHuggingPriority(hugging.priority, for: hugging.axis)
    }

    for compressionResistance in compressionResistances {
      view.setContentCompressionResistancePriority(compressionResistance.priority, for: compressionResistance.axis)
    }

    if let _width = layout.size?.width {
      view.widthEqual(constant: _width.value, priority: _width.priority)
    }
    if let _height = layout.size?.height {
      view.heightEqual(constant: _height.value, priority: _height.priority)
    }

    _subviewProtocols?.filter({ $0.view != nil }).forEach({ (viewModel) in
      let subview = viewModel.view!
      if view is UIScrollView {
        (view.subviews.first as! UIStackView).addArrangedSubview(subview)
      } else {
        view.addSubview(subview)
        if let _centerX = viewModel.layout.center?.x {
          subview.centerXEqualToSuperView(isSafeArea: viewModel.isSafeArea, constant: _centerX.value, priority: _centerX.priority)
        }
        if let _centerY = viewModel.layout.center?.y {
          subview.centerYEqualToSuperView(isSafeArea: viewModel.isSafeArea, constant: _centerY.value, priority: _centerY.priority)
        }
        if let _position = viewModel.layout.position {
          subview.positionSetToSuperView(isSafeArea: viewModel.isSafeArea, position: _position)
        }
        if let _margin = viewModel.layout.margin {
          subview.edgesEqualToSuperView(isSafeArea: viewModel.isSafeArea, margin: _margin)
        }
        if !viewModel.layout.isSetEdge {
          subview.edgesEqualToSuperView(isSafeArea: viewModel.isSafeArea)
        }
      }
    })
  }
}
