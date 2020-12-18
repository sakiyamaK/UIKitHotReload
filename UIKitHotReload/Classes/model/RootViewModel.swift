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
                             TableViewModelProtocol,
                             TextFieldModelProtocol {

  private enum CodingKeys: String, CodingKey {
    case
      //ViewModelProtocol
      className = "class",
      id = "id",
      width = "width",
      height = "height",
      filePath = "file_path",
      corner = "corner",
      border = "border",
      shadow = "shadow",
      circle = "circle",
      _backgroundColor = "background_color",
      _bgColor = "bg_color",
      _alpha = "alpha",
      _isHidden = "is_hidden", _hidden = "hidden",
      _huggings = "huggings",
      _compressionResistances = "compression_resistances",
      _contentMode = "content_mode",
      _subViewModelProtocols = "subviews",
      _isSafeArea = "is_safe_area", _safeArea = "safe_area",
      _layout = "layout",
      _clipToBounds = "clip_to_bounds",
      _clip = "clip",
      _isUserInteractionEnabled = "is_user_interaction_enabled",
      _userInteractionEnabled = "user_interaction_enabled",
      _enabled = "enabled",
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
      _separatorStyle = "separator_style",
      _sStyle = "s_style",
      _indicatorStyle = "indicator_style",
      _iStyle = "i_style",
      //TextFieldModelProtocol
      placeholder = "placeholder",
      _borderStyle = "border_style",
      _textContentType = "text_content_type",
      _capitalizationType = "capitalization_type",
      _capType = "cap_type",
      _keyboardType = "keyboard_type",
      _returnKeyType = "return_key_type",
      _isSecureTextEntry = "is_secure_text_entry",
      _secureTextEntry = "secure_text_entry",
      _secure = "secure",
      _enablesReturnKeyAutomatically = "enables_return_key_automatically"
  }

  //ViewModelProtocol
  public var className: String?
  public var id: String?
  public var width: CGFloat?
  public var height: CGFloat?
  public var filePath: String?
  public var corner: CornerModel?
  public var border: BorderModel?
  public var shadow: ShadowInfoModel?
  public var circle: CircleModel?
  public var _backgroundColor: [CGFloat]?
  public var _bgColor: [CGFloat]?
  public var _alpha: CGFloat?
  public var _isHidden, _hidden: Bool?
  public var _huggings: [HuggingModel]?
  public var _compressionResistances: [CompressionResistanceModel]?
  public var _contentMode: String?
  public var _subViewModelProtocols: [Self]?
  public var _isSafeArea, _safeArea: Bool?
  public var _tintColor: [CGFloat]?
  public var _layout: LayoutModel?
  public var _clipToBounds: Bool?
  public var _clip: Bool?
  public var _isUserInteractionEnabled: Bool?
  public var _userInteractionEnabled: Bool?
  public var _enabled: Bool?

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

  //TextModelProtocol
  public var text: String?
  public var _textColor: [CGFloat]?
  public var _textAlignment: String?
  public var _fontInfo: FontInfoModel?

  //LabelViewModelProtocol
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
//  public var _reuseIdentifier: String?
//  public var _reuseId: String?
//  public var _selectedBackgroundColor: [CGFloat]?

  //TextFieldModelProtocol
  public var placeholder: String?
  public var _borderStyle: String?
  public var _textContentType: String?
  public var _capitalizationType: String?
  public var _keyboardType: String?
  public var _capType: String?
  public var _returnKeyType: String?
  public var _isSecureTextEntry: Bool?
  public var _secureTextEntry: Bool?
  public var _secure: Bool?
  public var _enablesReturnKeyAutomatically: Bool?

  public var view: UIView? { viewModelType?.view }

  public func setupRootView(superview: UIView, isTop: Bool = true, fileType: FileType, snapshot: Bool? = nil) {
    guard let view = view else { return }
    if superview is UIScrollView {
      if let stackView = superview.subviews.first(where: {$0 is UIStackView}) as? UIStackView {
        if isTop {
          stackView.arrangedSubviews.forEach{ stackView.removeArrangedSubview($0) }
        } else {
          if id != nil, let subview = stackView.arrangedSubviews.first(where: { $0.accessibilityIdentifier == id }) {
            stackView.removeArrangedSubview(subview)
          }
        }
        stackView.addArrangedSubview(view)
      } else {
        print("setupRootView: subview of scrollview have to equal stackview")
        return
      }
    } else {
      if isTop {
        superview.subviews.forEach { $0.removeFromSuperview() }
      } else if id != nil {
        superview.subviews.first{ $0.accessibilityIdentifier == id }?.removeFromSuperview()
      }
      superview.addSubview(view)
    }

    setupView(view, fileType: fileType, snapshot: snapshot)

    if let label = view as? UILabel {
      setupLabel(label)
    } else if let button = view as? UIButton {
      setupButton(button)
    } else if let imageView = view as? UIImageView {
      setupImageView(imageView)
    } else if let textField = view as? UITextField {
      setupTextField(textField)
    } else if let tableView = view as? UITableView {
      setupTableView(tableView)
    } else if let scrollView = view as? UIScrollView {
      setupScrollView(scrollView)
    }

    _subViewModelProtocols?.forEach({ subViewModel in
      subViewModel.setupRootView(superview: view, isTop: false, fileType: fileType, snapshot: snapshot)
    })
  }
}
