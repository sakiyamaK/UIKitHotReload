//
//  EdgeInsets.swift
//  UIKitHotReload
//
//  Created by sakiyamaK on 2020/11/16.
//

public struct EdgeInsetsModel: Decodable {
  private var top: CGFloat?
  private var left: CGFloat?
  private var bottom: CGFloat?
  private var right: CGFloat?

  public var edgeInsets: UIEdgeInsets {
    var insets = UIEdgeInsets()
    insets.top = top ?? 0
    insets.left = left ?? 0
    insets.bottom = bottom ?? 0
    insets.right = right ?? 0
    return insets
  }

}
