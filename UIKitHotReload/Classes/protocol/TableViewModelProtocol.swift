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
  func setupTableView(_ tableView: UITableView)
}

public extension TableViewModelProtocol {
  func setupTableView(_ tableView: UITableView) {
  }
}
