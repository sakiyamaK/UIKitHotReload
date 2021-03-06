//
//  ButtomModelProtocol.swift
//  UIKitHotReload
//
//  Created by sakiyamaK on 2020/11/15.
//

import UIKit
import Kingfisher

public protocol ButtonModelProtocol: LabelModelProtocol, ImageViewModelProtocol {
  var _contentEdgeInsets: EdgeInsetsModel? { get }
  var _imageEdgeInsets: EdgeInsetsModel? { get }
  var _titleEdgeInsets: EdgeInsetsModel? { get }
  var _backgroundImageInfo: [String: String]? { get }
  var _imageContentMode: String? { get }

  func setupButton(_ button: UIButton)
}

public extension ButtonModelProtocol {
  var textColor: UIColor { _textColor?.uiColor ?? UIColor.systemBlue }
  var textAlignment: NSTextAlignment {  _textAlignment?.textAlignment ?? .center }
  var font: UIFont? {  _fontInfo?.font }
  var numberOfLines: Int { _numberOfLines ?? 1 }
  var contentEdgeInsets: UIEdgeInsets { _contentEdgeInsets?.edgeInsets ?? .zero }
  var imageEdgeInsets: UIEdgeInsets { _imageEdgeInsets?.edgeInsets ?? .zero }
  var titleEdgeInsets: UIEdgeInsets { _titleEdgeInsets?.edgeInsets ?? .zero }
  var imageContentMode: UIView.ContentMode? { _imageContentMode?.contentMode }

  func setupButton(_ button: UIButton) {
    button.setTitle(text, for: .normal)
    button.setTitleColor(textColor, for: .normal)
    if let _font = font {
      button.titleLabel?.font = _font
    }
    button.titleLabel?.textAlignment = textAlignment
    button.titleLabel?.numberOfLines = numberOfLines
    if let imageContentMode = imageContentMode {
      button.imageView?.contentMode = imageContentMode
    }
    button.contentEdgeInsets = contentEdgeInsets
    button.titleEdgeInsets = titleEdgeInsets
    button.imageEdgeInsets = imageEdgeInsets
    if let _name = _imageInfo?[ImageInfoKey.name.rawValue] {
      button.setImage(UIImage.init(named: _name), for: .normal)
    } else if let _urlStr = _imageInfo?[ImageInfoKey.url.rawValue], let url = URL(string: _urlStr) {
      button.kf.setImage(with: url, for: .normal)
    }
    if let _name = _backgroundImageInfo?[ImageInfoKey.name.rawValue] {
      button.setBackgroundImage(UIImage.init(named: _name), for: .normal)
      button.setImage(UIImage.init(named: _name), for: .normal)
    } else if let _urlStr = _backgroundImageInfo?[ImageInfoKey.url.rawValue], let url = URL(string: _urlStr) {
      button.kf.setBackgroundImage(with: url, for: .normal)
    }
  }
}
