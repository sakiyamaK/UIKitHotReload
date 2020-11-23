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

  private var label: UILabel? { self.hotReloadView(id: "test_cell_label") as? UILabel }

  override func prepareForReuse() {
    super.prepareForReuse()
    label?.text = nil
  }

  func configure(name: String) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {[weak self] in
      self?.label?.text = name
    }
  }
}

final class TableViewCellHotReload2: UITableViewCell {

  private var label: UILabel? { self.hotReloadView(id: "test_cell_label") as? UILabel }

  override func prepareForReuse() {
    super.prepareForReuse()
    label?.text = nil
  }

  func configure(name: String) {
    label?.text = name
  }
}

final class TableViewHeader: UITableViewHeaderFooterView {
  override func prepareForReuse() {
    super.prepareForReuse()
  }
}


final class TableViewController: UIViewController {

  private let dataSources: [String] = (1...30).map({"\($0)"})

  private var tableView: UITableView? { self.view.hotReloadView(id: "table_view") as? UITableView }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.loadHotReload(dirName: "views", jsonFileName: "table") { result in
      switch result {
      case .failure(let error):
        print(error.localizedDescription)
      default:
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.register(TableViewHeader.self, forHeaderFooterViewReuseIdentifier: "header")
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
    if indexPath.row%2 == 0 {
      let cell = tableView.dequeueOrRegisterCellHotReload(type: TableViewCellHotReload1.self, style: .default, dirName: "views", jsonFileName: "table", reuseIdentifier: "test_cell1") { result in
          switch result {
          case .failure(let error):
            print(error.localizedDescription)
          case .success(let (cell, isReload)):
            print("\(indexPath.row): \(name), \(isReload)")
            cell.configure(name: name)
            if isReload {
              tableView.reloadData()
            }
          }
        }
        return cell
    } else {
      let cell = tableView.dequeueOrRegisterCellHotReload(type: TableViewCellHotReload2.self, style: .default, dirName: "views", jsonFileName: "table", reuseIdentifier: "test_cell2") { result in
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
      return cell
    }
  }
}
