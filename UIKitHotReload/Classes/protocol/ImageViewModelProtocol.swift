//
//  ImageViewModelProtocol.swift
//  SampleFirebase
//
//  Created by sakiyamaK on 2020/10/12.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import UIKit
import Kingfisher

enum ImageInfoKey: String {
  case name, url
}

public protocol ImageViewModelProtocol: ViewModelProtocol {
  var _imageInfo: [String: String]? { get }
  func setupImageView(_ imageView: UIImageView)
}

public extension ImageViewModelProtocol {

  func setupImageView(_ imageView: UIImageView) {
    if let _name = _imageInfo?[ImageInfoKey.name.rawValue] {
      imageView.image = UIImage.init(named: _name)
    } else if let _urlStr = _imageInfo?[ImageInfoKey.url.rawValue], let url = URL(string: _urlStr) {
      imageView.kf.setImage(with: url)
    }
  }
}
