//
//  TableViewController.swift
//  UIKitHotReload_Example
//
//  Created by sakiyamaK on 2020/11/21.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import UIKitHotReload

final class TableViewCellHotReload1: UITableViewCell {

  private var label1: UILabel? { self.hotReloadView(id: "test_cell_label1") as? UILabel }
  private var label2: UILabel? { self.hotReloadView(id: "test_cell_label2") as? UILabel }

  override func prepareForReuse() {
    super.prepareForReuse()
    label1?.text = nil
    label2?.text = nil
  }

  func configure(name: String) {
    label1?.text = name
    label2?.text = name
  }
}


final class TableViewHeader: UITableViewHeaderFooterView {
  override func prepareForReuse() {
    super.prepareForReuse()
  }
}


final class TableViewController: UIViewController {

  private var dataSources: [String] = (1...30).map({"\($0)"})

  private var tableView: UITableView? { self.view.hotReloadView(id: "table_view") as? UITableView }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.view.loadHotReload(dirName: "views", jsonFileName: "table") {[weak self] result in
      guard let self = self else { return }
      switch result {
      case .failure(let error):
        print(error.localizedDescription)
      default:
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
      }
    }
  }
}

extension TableViewController: UITableViewDelegate {

}

extension TableViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    dataSources.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let name = dataSources[indexPath.row]
    let cell = tableView.dequeueOrRegisterCellHotReload(type: TableViewCellHotReload1.self, style: .default, dirName: "components", jsonFileName: "table_cell1", reuseIdentifier: "TableViewCellHotReload1") { (result) in
      switch result {
      case .failure(let error):
        print(error.localizedDescription)
      case .success(let (cell, isReload)):
        cell.configure(name: name)
        if isReload {
          tableView.reloadData()
        }
      }
    }
//    guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellHotReload1") as? TableViewCellHotReload1 else {
//      return UITableViewCell()
//    }
//    cell.configure(name: name)
    return cell
  }
}
