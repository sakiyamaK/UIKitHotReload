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
    label?.text = name
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
      if let cell = tableView.dequeueReusableCell(withIdentifier: "test_cell1") as? TableViewCellHotReload1 {
        cell.configure(name: name)
        return cell
      } else {
        let cell = TableViewCellHotReload1(style: .default, dirName: "views", jsonFileName: "table", reuseIdentifier: "test_cell1") { result in
          switch result {
          case .failure(let error):
            print(error.localizedDescription)
          case .success():
            tableView.reloadData()
            break
          }
        }
        cell.configure(name: name)
        return cell
      }
    } else {
      if let cell = tableView.dequeueReusableCell(withIdentifier: "test_cell2") as? TableViewCellHotReload2 {
        cell.configure(name: name)
        return cell
      } else {
        let cell = TableViewCellHotReload2(style: .default, dirName: "views", jsonFileName: "table", reuseIdentifier: "test_cell2") { result in
          switch result {
          case .failure(let error):
            print(error.localizedDescription)
          case .success():
            tableView.reloadData()
            break
          }
        }
        cell.configure(name: name)
        return cell
      }
    }
  }
}
