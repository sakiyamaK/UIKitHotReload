//
//  TwitterViewController.swift
//  UIKitHotReload_Example
//
//  Created by sakiyamaK on 2020/11/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import UIKitHotReload
import Kingfisher


final class TwitterTimelineViewController: UIViewController {

  private var dataSources: [TwitterTimelineModel] = []

  private var tableView: UITableView? { self.view.hotReloadView(id: "tableview") as? UITableView }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.view.loadHotReload(dirName: "views", jsonFileName: "twitter_timeline") {[weak self] result in
      guard let self = self else { return }
      switch result {
      case .failure(let error):
        print(error.localizedDescription)
      default:
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        DemoAPI.shared.getTwitterTimelines { result in
          print(result)
          switch result {
          case .failure(let error):
            print(error.localizedDescription)
          case .success(let timelines):
            self.dataSources = timelines + Array(1...97).map { _ in  timelines.randomElement()! }
            self.tableView?.reloadData()
          }
        }
      }
    }
  }
}

extension TwitterTimelineViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let user = dataSources[indexPath.row]
    Router.showAlert(message: "\(user.name ?? "no name")です", vc: self)
  }
}

extension TwitterTimelineViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    dataSources.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let user = dataSources[indexPath.row]
    let cell = tableView.dequeueOrRegisterCellHotReload(
      type: TwitterTimelineCell.self,
      style: .default,
      reuseIdentifier: "TwitterTimelineCell",
      dirName: "components", fileName: "twitter_timeline_cell") { (result) in
      switch result {
      case .failure(let error):
        print(error.localizedDescription)
      case .success(let (cell, isReload)):
        cell.configure(user: user)
        if isReload {
          tableView.reloadData()
        }
      }
    }
    return cell
  }
}
