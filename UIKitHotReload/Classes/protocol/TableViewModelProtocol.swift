//
//  TableViewCell.swift
//  UIKitHotReload
//
//  Created by sakiyamaK on 2020/11/21.
//

import UIKit

public protocol TableViewModelProtocol: ViewModelProtocol {
  associatedtype TableViewCellModel: TableViewCellModelProtocol
  var cells: [TableViewCellModel]? { get }
//  var header: String? { get }
//  var footer: String? { get }
  var _separatorStyle: String? { get }
  var _sStyle: String? { get }
  var _indicatorStyle: String? { get }
  var _iStyle: String? { get }
  func setupTableView(_ tableView: UITableView)
}

public extension TableViewModelProtocol {
  var separatorStyle: UITableViewCell.SeparatorStyle? { [_separatorStyle, _sStyle].first{$0 != nil}??.separatorStyle }
  var indicatorStyle: UITableView.IndicatorStyle? { [_indicatorStyle, _iStyle].first{$0 != nil}??.indicatorStyle }
  func setupTableView(_ tableView: UITableView) {
    if let separatorStyle = separatorStyle {
      tableView.separatorStyle = separatorStyle
    }
    if let indicatorStyle = indicatorStyle {
      tableView.indicatorStyle = indicatorStyle
    }
  }
}
