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
                             ViewModelProtocol, StackViewModelProtocol,
                             LabelModelProtocol, ImageViewModelProtocol, ButtonModelProtocol {

  private enum CodingKeys: String, CodingKey {
    case id, width, height, text
    case
      className = "class",
      _isHidden = "hidden",
      _alpha = "alpha",
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
      _spacing = "spacing",
      isScrollEnabled = "is_scroll_enabled",
      _numberOfLines = "number_of_lines",
      _edgePriority = "edge_priority",
      _edgeInsets = "edge_insets",
      _isSafeArea = "is_safe_area"
  }

  //ViewModelProtocol
  public var className: String?
  public var id: String?
  public var width: CGFloat?
  public var height: CGFloat?
  public var text: String?

  public var _backgroundColor: [CGFloat]?
  public var _alpha: CGFloat?
  public var _isHidden: Bool?
  public var _huggings: [HuggingModel]?
  public var _compressionResistances: [CompressionResistanceModel]?
  public var _contentMode: String?
  public var _alignment: String?
  public var _distribution: String?
  public var _axis: String?
  public var _spacing: CGFloat?
  public var _subviewProtocols: [Self]?
  public var _edgePriority: EdgePriorityModel?
  public var _edgeInsets: EdgeInsetsModel?
  public var _textColor: [CGFloat]?
  public var _textAlignment: String?
  public var _imageInfo: [String : String]?
  public var _fontInfo: FontInfoModel?

  public var isScrollEnabled: Bool?
  public var _numberOfLines: Int?
  public var _isSafeArea: Bool?

  public var view: UIView? {
    if let label = viewModelType?.view as? UILabel {
      setupView(label)
      setupLabel(label)
      return label
    } else if let button = viewModelType?.view as? UIButton {
      setupView(button)
      setupButton(button)
      return button
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
