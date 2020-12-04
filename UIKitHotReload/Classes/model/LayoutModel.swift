//
//  LayoutModel.swift
//  UIKitHotReload
//
//  Created by sakiyamaK on 2020/11/18.
//

import Foundation

public struct ValueAndPriority: Decodable {
  private enum CodingKeys: String, CodingKey {
    case
      _value = "value", _v = "v",
      _priority = "priority", _p = "p",
      _remove = "remove", _r = "r"
  }
  private var _value: CGFloat?
  private var _v: CGFloat?
  private var _priority: Float?
  private var _p: Float?
  private var _remove: Bool?
  private var _r: Bool?

  public var value: CGFloat { [_value, _v].first{$0 != nil} as? CGFloat ?? 0.0 }
  public var priority: UILayoutPriority {
    UILayoutPriority(
      [_priority, _p].first{$0 != nil}?.map{max($0, 1.0)} ?? UILayoutPriority.required.rawValue
    )
  }
  public var remove: Bool { [_remove, _r].first{$0 != nil} as? Bool ?? false }
}

public struct LayoutModel: Decodable {
  public struct SizeModel: Decodable {
    public var width: ValueAndPriority?
    public var height: ValueAndPriority?
  }

  public struct CenterModel: Decodable {
    public var x: ValueAndPriority?
    public var y: ValueAndPriority?
  }

  public struct EdgeModel: Decodable {
    private enum CodingKeys: String, CodingKey {
      case
        top = "top",
        bottom = "bottom",
        _leading = "leading", _left = "left",
        _trailing = "trailing", _right = "right"
    }

    public var top: ValueAndPriority?
    public var bottom: ValueAndPriority?

    private var _leading: ValueAndPriority?
    private var _left: ValueAndPriority?
    private var _trailing: ValueAndPriority?
    private var _right: ValueAndPriority?

    public var leading: ValueAndPriority? { [_leading, _left].first{$0 != nil} as? ValueAndPriority }
    public var trailing: ValueAndPriority? { [_trailing, _right].first{$0 != nil} as? ValueAndPriority }

    static var allDefault: EdgeModel {
      EdgeModel(top: .init(), bottom: .init(), _leading: .init(), _left: .init(), _trailing: .init(), _right: .init())
    }
  }

  private enum CodingKeys: String, CodingKey {
    case
      size = "size",
      center = "center",
      position = "position",
      margin = "margin",
      _aspectRatio = "aspect_ratio",
      _ratio = "ratio"
  }

  public var size: SizeModel?
  public var center: CenterModel?
  public var position: EdgeModel?
  public var margin: EdgeModel?
  private var _aspectRatio: ValueAndPriority?
  private var _ratio: ValueAndPriority?

  public var aspectRatio: ValueAndPriority? { [_aspectRatio, _ratio].first{$0 != nil} as? ValueAndPriority }
  public var isSetEdge: Bool { position != nil || margin != nil || center != nil }
  public var isSetWidthHeight: Bool { size?.width != nil && size?.height != nil }
}
