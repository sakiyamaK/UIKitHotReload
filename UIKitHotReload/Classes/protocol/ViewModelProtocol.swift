//
//  ViewModelProtocol.swift
//  SampleFirebase
//
//  Created by sakiyamaK on 2020/10/12.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import UIKit
import FirebaseFirestore

public protocol ViewModelProtocol: IDProtocol {
  var className: String? { get }
  var width: CGFloat? { get }
  var height: CGFloat? { get }
  var view: UIView? { get }
  var filePath: String? { get }
  var corner: CornerModel? { get }
  var border: BorderModel? { get }
  var shadow: ShadowInfoModel? { get }
  var circle: CircleModel? { get }

  var _backgroundColor: [CGFloat]?  { get }
  var _bgColor: [CGFloat]?  { get }
  var _contentMode: String? { get }
  var _alpha: CGFloat? { get }
  var _isHidden: Bool? { get }
  var _hidden: Bool? { get }
  var _layouts: [LayoutModel]? { get }
  var _huggings: [HuggingModel]?  { get }
  var _compressionResistances: [CompressionResistanceModel]?  { get }
  var _isSafeArea: Bool? { get }
  var _safeArea: Bool? { get }
  var _tintColor: [CGFloat]?  { get }
  var _clipToBounds: Bool? { get }
  var _clip: Bool? { get }
  var _isUserInteractionEnabled: Bool? { get }
  var _userInteractionEnabled: Bool? { get }
  var _enabled: Bool? { get }
  var _subViewModelProtocols: [Self]? { get }

  func setupView(_ view: UIView, fileType: FileType, snapshot: Bool?)
}

public extension ViewModelProtocol {
  var backgroundColor: UIColor { ([_backgroundColor, _bgColor].first { $0 != nil} as? [CGFloat])?.uiColor ?? .white }
  var contentMode: UIView.ContentMode { (_contentMode ?? "").contentMode }
  var viewModelType: ViewModelType? { ViewModelType(rawValue: className?.lowercased() ?? "") }
  var layouts: [LayoutModel] { _layouts ?? [LayoutModel()] }
  var huggings: [HuggingModel] { _huggings ?? [] }
  var compressionResistances: [CompressionResistanceModel]  { _compressionResistances ?? [] }
  var isSafeArea: Bool { [_isSafeArea, _safeArea].first{$0 == true} as? Bool ?? false }
  var alpha: CGFloat { _alpha ?? 1.0 }
  var isHidden: Bool { [_isHidden, _hidden].first{$0 == true} as? Bool ?? false }
  var isUserInteractionEnabled: Bool {  [_isUserInteractionEnabled, _userInteractionEnabled, _enabled].first{$0 != nil } as? Bool ?? true }
  var tintColor: UIColor { _tintColor?.uiColor ?? UIColor.clear }
  var clipToBounds: Bool { [_clipToBounds, _clip].first{$0 != nil} as? Bool ?? false }

  func setupView(_ view: UIView, fileType: FileType, snapshot: Bool?) {

    view.accessibilityIdentifier = id
    view.backgroundColor = backgroundColor
    view.contentMode = contentMode
    view.alpha = alpha
    view.isHidden = isHidden
    view.tintColor = tintColor
    view.clipsToBounds = clipToBounds
    view.isUserInteractionEnabled = isUserInteractionEnabled
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

    if let (dirName, fileName) = filePath?.viewPath {
      let completion: ((Result<Void, Error>) -> Void) = { result in
        switch result {
        case .failure(let error):
          print("\(dirName)/\(fileName): \(error.localizedDescription)")
        default:
          break
        }
      }

      switch fileType {
      case .json:
        view.loadHotReload(dirName: dirName, jsonFileName: fileName, snapshot: snapshot, completion: completion)
      case .yaml:
        view.loadHotReload(dirName: dirName, yamlFileName: fileName, snapshot: snapshot, completion: completion)
      case .yml:
        view.loadHotReload(dirName: dirName, ymlFileName: fileName, snapshot: snapshot, completion: completion)
      }
      return
    }

    for hugging in huggings {
      view.setContentHuggingPriority(hugging.priority, for: hugging.axis)
    }

    for compressionResistance in compressionResistances {
      view.setContentCompressionResistancePriority(compressionResistance.priority, for: compressionResistance.axis)
    }

    for layout in layouts {
      if let _width = layout.size?.width {
        view.widthEqual(id: _width.id, isActive: _width.active, constant: _width.value, priority: _width.priority)
      }
      if let _height = layout.size?.height {
        view.heightEqual(id: _height.id, isActive: _height.active, constant: _height.value, priority: _height.priority)
      }

      if !layout.isSetWidthHeight, let _aspectRatio = layout.aspectRatio {
        view.aspectRatio(id: _aspectRatio.id, isActive: _aspectRatio.active, aspectRatio: _aspectRatio.value, priority: _aspectRatio.priority, isSetWidth: layout.size?.width != nil)
      }

      if let _centerX = layout.center?.x {
        view.centerXEqualToSuperView(id: _centerX.id, isSafeArea: isSafeArea,  isActive: _centerX.active, constant: _centerX.value, priority: _centerX.priority)
      }
      if let _centerY = layout.center?.y {
        view.centerYEqualToSuperView(id: _centerY.id, isSafeArea: isSafeArea, isActive: _centerY.active, constant: _centerY.value, priority: _centerY.priority)
      }
      if let _position = layout.position {
        view.positionSetToSuperView(isSafeArea: isSafeArea, position: _position)
      }

      let isSuperViewScroll = view.superview is UIScrollView
      if let _margin = layout.margin {
        view.edgesEqualToSuperView(isSafeArea: isSafeArea, margin: isSuperViewScroll ? nil : _margin)
      }

      let isSuperViewStack = view.superview is UIStackView
      if !isSuperViewStack && !layout.isSetEdge {
        view.edgesEqualToSuperView(isSafeArea: isSafeArea)
      }
    }
  }
}
