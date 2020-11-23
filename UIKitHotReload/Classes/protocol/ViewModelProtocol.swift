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
  var jsonFilePath: String? { get }
  var corner: CornerModel? { get }
  var border: BorderModel? { get }
  var shadow: ShadowInfoModel? { get }
  var circle: CircleModel? { get }

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
  var _tintColor: [CGFloat]?  { get }
  var _clipToBounds: Bool? { get }
  var _clip: Bool? { get }
  var _subViewModelProtocols: [Self]? { get }

  func setupView(_ view: UIView, isSuperViewStack: Bool, snapshot: Bool?)
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

  func setupView(_ view: UIView, isSuperViewStack: Bool = false, snapshot: Bool? = nil) {

    view.accessibilityIdentifier = id
    view.backgroundColor = backgroundColor
    view.contentMode = contentMode
    view.alpha = alpha
    view.isHidden = isHidden
    view.tintColor = tintColor
    view.clipsToBounds = clipToBounds
    if let corner = corner {
      view.layer.cornerRadius = corner.radius
      view.layer.maskedCorners = corner.maskedCorners
    }
    if let border = border {
      view.layer.borderWidth = border.width
      view.layer.borderColor = border.color.cgColor
    }
    if let shadow = shadow {
      view.layer.shadowOpacity = shadow.opacity
      view.layer.shadowRadius = shadow.radius
      view.layer.shadowOffset = shadow.offset
      view.layer.shadowColor = shadow.color.cgColor
    }
    if let circle = circle {
      view.clipsToBounds = true
      view.layer.cornerRadius = circle.radius
      view.layer.borderWidth = circle.borderWidth
      view.layer.borderColor = circle.borderColor.cgColor
    }

    if let (dirName, jsonFileName) = jsonFilePath?.viewPath {
      view.loadHotReload(dirName: dirName, jsonFileName: jsonFileName, snapshot: snapshot) { result in
        switch result {
        case .failure(let error):
          print("\(dirName)/\(jsonFileName): \(error.localizedDescription)")
        default:
          break
        }
      }
      return
    }

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

    if let _centerX = layout.center?.x {
      view.centerXEqualToSuperView(isSafeArea: isSafeArea, constant: _centerX.value, priority: _centerX.priority)
    }
    if let _centerY = layout.center?.y {
      view.centerYEqualToSuperView(isSafeArea: isSafeArea, constant: _centerY.value, priority: _centerY.priority)
    }
    if let _position = layout.position {
      view.positionSetToSuperView(isSafeArea: isSafeArea, position: _position)
    }
    if let _margin = layout.margin {
      view.edgesEqualToSuperView(isSafeArea: isSafeArea, margin: _margin)
    }
    if !isSuperViewStack && !layout.isSetEdge {
      view.edgesEqualToSuperView(isSafeArea: isSafeArea)
    }
  }
}
