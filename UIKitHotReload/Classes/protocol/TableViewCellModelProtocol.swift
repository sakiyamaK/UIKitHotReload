//
//  TableViewCellModelProtocol.swift
//  UIKitHotReload
//
//  Created by sakiyamaK on 2020/11/21.
//

import UIKit

public protocol TableViewCellModelProtocol: ViewModelProtocol {
  var _reuseIdentifier: String? { get }
  var _reuseId: String? { get }
  var _selectedBackgroundColor: [CGFloat]? { get }
}

public extension TableViewCellModelProtocol {
  var selectedBackgroundColor: UIColor? { _selectedBackgroundColor?.uiColor }
  var reuseIdentifier: String? { [_reuseIdentifier, _reuseId].first{$0 != nil} as? String }
}
