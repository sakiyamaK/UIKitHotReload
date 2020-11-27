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

final class DemoAPI {
  static let shared = DemoAPI()
  private init() { }

  private let decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
  }()

  func getTwitterTimelines(completion:((Result<[TwitterTimelineModel], Error>) -> Void )? = nil) {
    guard let path = Bundle.main.path(forResource: "twitter_timelines", ofType: "json") else {
      let error = NSError.init(domain: "no file", code: 120, userInfo: nil)
      completion?(.failure(error))
      return
    }
    do {
      let fileUrl = URL(fileURLWithPath: path)
      let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
      let timelines = try JSONDecoder().decode([TwitterTimelineModel].self, from: data)
      completion?(.success(timelines))
    } catch(let error) {
      completion?(.failure(error))
    }
  }

}

final class TwitterTimelineModel: Codable {
  var id: Int
  var name: String?
  var atName: String?
  var timeAgo: String?
  var mainText: String?
  var iconImageUrlStr: String?
}

final class TwitterTimelineCell: UITableViewCell {

  private var nameLabel: UILabel? { self.hotReloadView(id: "name_label") as? UILabel }
  private var atNameLabel: UILabel? { self.hotReloadView(id: "at_name_label") as? UILabel }
  private var timeAgoLabel: UILabel? { self.hotReloadView(id: "time_ago_label") as? UILabel }
  private var mainTextLabel: UILabel? { self.hotReloadView(id: "main_text_label") as? UILabel }
  private var optionImageView: UIImageView? { self.hotReloadView(id: "option_iamge_view") as? UIImageView }
  private var iconImageView: UIImageView? { self.hotReloadView(id: "icon_iamge_view") as? UIImageView }

  override func prepareForReuse() {
    super.prepareForReuse()
    self.nameLabel?.text = nil
    self.atNameLabel?.text = nil
    self.timeAgoLabel?.text = nil
    self.mainTextLabel?.text = nil
    self.iconImageView?.image = nil
//    self.optionImageView
  }

  func configure(user: TwitterTimelineModel) {
    self.nameLabel?.text = user.name
    self.atNameLabel?.text = user.atName
    self.timeAgoLabel?.text = user.timeAgo
    self.mainTextLabel?.text = user.mainText
    if let urlStr = user.iconImageUrlStr, let url = URL.init(string: urlStr) {
      self.iconImageView?.kf.setImage(with: url)
    }
  }
}



final class TwitterTimelineViewController: UIViewController {

  private var dataSources: [TwitterTimelineModel] = []

  private var tableView: UITableView? { self.view.hotReloadView(id: "table_view") as? UITableView }

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
          switch result {
          case .failure(let error):
            print(error.localizedDescription)
          case .success(let timelines):
            self.dataSources = timelines
            self.tableView?.reloadData()
          }
        }
      }
    }
  }
}

extension TwitterTimelineViewController: UITableViewDelegate {

}

extension TwitterTimelineViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    dataSources.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let user = dataSources[indexPath.row]
    let cell = tableView.dequeueOrRegisterCellHotReload(type: TwitterTimelineCell.self, style: .default, dirName: "components", jsonFileName: "twitter_timeline_cell", reuseIdentifier: "TwitterTimelineCell") { (result) in
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