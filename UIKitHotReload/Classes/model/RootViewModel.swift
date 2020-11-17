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
    case
      //ViewModelProtocol
      className = "class",
      id = "id",
      width = "width",
      height = "height",
      _backgroundColor = "background_color",
      _alpha = "alpha",
      _isHidden = "is_hidden", _hidden = "hidden",
      _huggings = "huggings",
      _compressionResistances = "compression_resistances",
      _contentMode = "content_mode",
      _subviewProtocols = "subviews",
      _edgePriority = "edge_priority",
      _edgeInsets = "edge_insets",
      _isSafeArea = "is_safe_area", _safeArea = "safe_area",
      _cornerRadius = "corner_radius",
      _masksToBounds = "masks_to_bounds",
      _maskedCorners = "masked_corners",
      _borderWidth = "border_width",
      _borderColor = "border_color",
      _tintColor = "tint_color",
      _shadow = "shadow",
      //StackViewModelProtocol
      _alignment = "alignment",
      _distribution = "distribution",
      _axis = "axis",
      _spacing = "spacing",
      _isScrollEnabled = "is_scroll_enabled", _scrollEnabled = "scroll_enabled",
      _isPagingEnabled = "is_paging_enabled", _pagingEnabled = "paging_enabled",
      _showsVerticalScrollIndicator = "shows_vertical_scroll_indicator", _vIndicator = "v_indicator",
      _showsHorizontalScrollIndicator = "shows_horizontal_scroll_indicator", _hIndicator = "h_indicator",
      _contentInsets = "content_insets",
      _contentOffset = "content_offset",
      //LabelViewModelProtocol
      text = "text",
      _textColor = "text_color",
      _textAlignment = "text_alignment",
      _fontInfo = "font",
      _numberOfLines = "number_of_lines",
      //ImageViewModelProtocol
      _imageInfo = "image",
      //ButtonViewModelProtocol
      _contentEgeInsets = "content_ege_insets",
      _imageEgeInsets = "image_ege_insets",
      _titleEgeInsets = "title_ege_insets",
      _backgroundImageInfo = "background_image",
      _imageContentMode = "image_content_mode"
  }

  //ViewModelProtocol
  public var className: String?
  public var id: String?
  public var width: CGFloat?
  public var height: CGFloat?
  public var _backgroundColor: [CGFloat]?
  public var _alpha: CGFloat?
  public var _isHidden, _hidden: Bool?
  public var _huggings: [HuggingModel]?
  public var _compressionResistances: [CompressionResistanceModel]?
  public var _contentMode: String?
  public var _subviewProtocols: [Self]?
  public var _edgePriority: EdgePriorityModel?
  public var _edgeInsets: EdgeInsetsModel?
  public var _isSafeArea, _safeArea: Bool?
  public var _cornerRadius: CGFloat?
  public var _masksToBounds: Bool?
  public var _maskedCorners: [String]?
  public var _borderWidth: CGFloat?
  public var _borderColor: [CGFloat]?
  public var _tintColor: [CGFloat]?
  public var _shadow: ShadowInfoModel?

  //StackViewModelProtocol
  public var _alignment: String?
  public var _distribution: String?
  public var _axis: String?
  public var _spacing: CGFloat?
  public var _isScrollEnabled, _scrollEnabled: Bool?
  public var _isPagingEnabled, _pagingEnabled: Bool?
  public var _showsVerticalScrollIndicator, _vIndicator: Bool?
  public var _showsHorizontalScrollIndicator, _hIndicator: Bool?
  public var _contentInsets: EdgeInsetsModel?
  public var _contentOffset: CGPoint?

  //LabelViewModelProtocol, ButtonModelProtocol
  public var text: String?
  public var _textColor: [CGFloat]?
  public var _textAlignment: String?
  public var _fontInfo: FontInfoModel?
  public var _numberOfLines: Int?

  //ImageViewModelProtocol
  public var _imageInfo: [String : String]?

  //ButtonModelProtocol
  public var _contentEgeInsets: EdgeInsetsModel?
  public var _imageEgeInsets: EdgeInsetsModel?
  public var _titleEgeInsets: EdgeInsetsModel?
  public var _backgroundImageInfo: [String: String]?
  public var _imageContentMode: String?

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
