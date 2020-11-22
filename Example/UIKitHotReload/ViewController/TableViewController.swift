//
//  TableViewController.swift
//  UIKitHotReload_Example
//
//  Created by sakiyamaK on 2020/11/21.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import UIKitHotReload

final class TableViewCellHotReload: UITableViewCell {

  private var label: UILabel? { self.hotReloadView(id: "test_cell_label") as? UILabel }

  init(style: UITableViewCellStyle, reuseIdentifier: String?, completion: ((Result<Void, Error>) -> Void)? = nil) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.loadTableViewCellHotReload(collectionName: "views", documentName: "table", reuseIdentifier: reuseIdentifier!, completion: completion)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

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
    if let cell = tableView.dequeueReusableCell(withIdentifier: "test_cell") as? TableViewCellHotReload {
      cell.configure(name: name)
      return cell
    } else {
      let cell = TableViewCellHotReload(style: .default, reuseIdentifier: "test_cell") { result in
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
