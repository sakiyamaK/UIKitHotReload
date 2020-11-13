//
//  RootViewModelProtocol.swift
//  SampleFirebase
//
//  Created by sakiyamaK on 2020/10/12.
//  Copyright © 2020 sakiyamaK. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift

public struct RootViewModel: Decodable,
                             ViewModelProtocol, StackViewModelProtocol, LabelModelProtocol, ImageViewModelProtocol {

  private enum CodingKeys: String, CodingKey {
    case identifier, width, height, alpha, text
    case
    className = "class",
    isHidden = "hidden",
    _backgroundColor = "background_color",
    _textColor = "text_color",
    _textAlignment = "text_alignment",
    _subviewProtocols = "subviews",
    _huggings = "huggings",
    _compressionResistances = "compression_resistances",
    _contentMode = "content_mode",
    _alignment = "alignment",
    _distribution = "distribution",
    _axis = "axis",
    _imageInfo = "image",
    _fontInfo = "font",
    isScrollEnabled = "is_scroll_enabled",
    numberOfLines = "number_of_lines",
    edgePriority = "edge_priority"
  }

  public var className: String?
  public var identifier: String?
  public var _backgroundColor: [CGFloat]?
  public var width: CGFloat?
  public var height: CGFloat?
  public var alpha: CGFloat?
  public var isHidden: Bool?
  public var _huggings: [HuggingModel]?
  public var _compressionResistances: [CompressionResistanceModel]?
  public var _contentMode: String?
  public var _alignment: String?
  public var _distribution: String?
  public var _axis: String?
  public var _subviewProtocols: [Self]?
  public var edgePriority: EdgePriorityModel?

  public var text: String?
  public var _textColor: [CGFloat]?
  public var _textAlignment: String?
  public var _imageInfo: [String : String]?
  public var _fontInfo: FontInfoModel?
  public var numberOfLines: Int?

  public var isScrollEnabled: Bool?
  public var isSafeArea: Bool?

  public var view: UIView? {
    if let label = viewModelType?.view as? UILabel {
      setupView(label)
      setupLabel(label)
      return label
    } else if let imageView = viewModelType?.view as? UIImageView {
      setupView(imageView)
      setupImageView(imageView)
      return imageView
    } else if let scrollView = viewModelType?.view as? UIScrollView {
      setupView(scrollView)
      setupScrollView(scrollView)
      return scrollView
    } else if let view = viewModelType?.view {
      setupView(view)
      return view
    } else {
      return nil
    }
  }
}
