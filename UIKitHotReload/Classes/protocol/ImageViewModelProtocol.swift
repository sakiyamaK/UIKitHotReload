//
//  ImageViewModelProtocol.swift
//  SampleFirebase
//
//  Created by sakiyamaK on 2020/10/12.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import UIKit
import Kingfisher

public protocol ImageViewModelProtocol: ViewModelProtocol {
  var _imageInfo: [String: String]? { get }
  func setupImageView(_ imageView: UIImageView)
}

public extension ImageViewModelProtocol {

  func setupImageView(_ imageView: UIImageView) {
    if let _name = _imageInfo?["name"] {
      imageView.image = UIImage.init(named: _name)
    } else if let _urlStr = _imageInfo?["url"], let url = URL(string: _urlStr) {
      imageView.kf.setImage(with: url)
    }
  }
}
