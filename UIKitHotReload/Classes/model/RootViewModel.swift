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

public struct RootViewModel: Decodable, ViewModelProtocol, StackViewModelProtocol,
                             LabelModelProtocol, ImageViewModelProtocol, ButtonModelProtocol,
                             TableViewModelProtocol, TableViewCellModelProtocol {

  private enum CodingKeys: String, CodingKey {
    case
      //ViewModelProtocol
      className = "class",
      id = "id",
      width = "width",
      height = "height",
      jsonFilePath = "json_file_path",
      corner = "corner",
      border = "border",
      shadow = "shadow",
      circle = "circle",
      _backgroundColor = "background_color",
      _alpha = "alpha",
      _isHidden = "is_hidden", _hidden = "hidden",
      _huggings = "huggings",
      _compressionResistances = "compression_resistances",
      _contentMode = "content_mode",
      _subviewProtocols = "subviews",
      _isSafeArea = "is_safe_area", _safeArea = "safe_area",
      _layout = "layout",
      _clipToBounds = "clip_to_bounds",
      _clip = "clip",
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
      _contentEdgeInsets = "content_edge_insets",
      _imageEdgeInsets = "image_edge_insets",
      _titleEdgeInsets = "title_edge_insets",
      _backgroundImageInfo = "background_image",
      _imageContentMode = "image_content_mode",
      //TableViewModelProtocol
      cells = "cells",
      _separatorStyle = "separator_style",
      _sStyle = "s_style",
      _indicatorStyle = "indicator_style",
      _iStyle = "i_style",
      //TableViewCellModelProtocol
      _reuseIdentifier = "reuse_identifier",
      _reuseId = "reuse_id",
      _selectedBackgroundColor = "selected_background_color"
  }

  public var snapshot: Bool?

  //ViewModelProtocol
  public var className: String?
  public var id: String?
  public var width: CGFloat?
  public var height: CGFloat?
  public var jsonFilePath: String?
  public var corner: CornerModel?
  public var border: BorderModel?
  public var shadow: ShadowInfoModel?
  public var circle: CircleModel?
  public var _backgroundColor: [CGFloat]?
  public var _alpha: CGFloat?
  public var _isHidden, _hidden: Bool?
  public var _huggings: [HuggingModel]?
  public var _compressionResistances: [CompressionResistanceModel]?
  public var _contentMode: String?
  public var _subviewProtocols: [Self]?
  public var _isSafeArea, _safeArea: Bool?
  public var _tintColor: [CGFloat]?
  public var _layout: LayoutModel?
  public var _clipToBounds: Bool?
  public var _clip: Bool?

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

  //LabelViewModelProtocol
  public var text: String?
  public var _textColor: [CGFloat]?
  public var _textAlignment: String?
  public var _fontInfo: FontInfoModel?
  public var _numberOfLines: Int?

  //ImageViewModelProtocol
  public var _imageInfo: [String : String]?

  //ButtonModelProtocol
  public var _contentEdgeInsets: EdgeInsetsModel?
  public var _imageEdgeInsets: EdgeInsetsModel?
  public var _titleEdgeInsets: EdgeInsetsModel?
  public var _backgroundImageInfo: [String: String]?
  public var _imageContentMode: String?

  //TableViewModelProtocol
  public var cells: [Self]?
  public var _separatorStyle: String?
  public var _sStyle: String?
  public var _indicatorStyle: String?
  public var _iStyle: String?

  //TableViewCellModelProtocol
  public var _reuseIdentifier: String?
  public var _reuseId: String?
  public var _selectedBackgroundColor: [CGFloat]?

  public var view: UIView? {
    if let label = viewModelType?.view as? UILabel {
      setupView(label, snapshot: snapshot)
      setupLabel(label)
      return label
    } else if let button = viewModelType?.view as? UIButton {
      setupView(button, snapshot: snapshot)
      setupButton(button)
      return button
    } else if let imageView = viewModelType?.view as? UIImageView {
      setupView(imageView, snapshot: snapshot)
      setupImageView(imageView)
      return imageView
    } else if let tableView = viewModelType?.view as? UITableView {
      setupView(tableView, snapshot: snapshot)
      setupTableView(tableView)
      return tableView
    } else if let scrollView = viewModelType?.view as? UIScrollView {
      setupView(scrollView, snapshot: snapshot)
      setupScrollView(scrollView)
      return scrollView
    } else if let view = viewModelType?.view {
      if reuseIdentifier == nil {
        setupView(view, snapshot: snapshot)
      }
      return view
    } else {
      return nil
    }
  }
}
