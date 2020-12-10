//
//  TwitterTimelineCell.swift
//  UIKitHotReload_Example
//
//  Created by sakiyamaK on 2020/12/10.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

final class TwitterTimelineCell: UITableViewCell {

  private var nameLabel: UILabel? { self.hotReloadView(id: "name_label") as? UILabel }
  private var atNameLabel: UILabel? { self.hotReloadView(id: "at_name_label") as? UILabel }
  private var timeAgoLabel: UILabel? { self.hotReloadView(id: "time_ago_label") as? UILabel }
  private var mainTextLabel: UILabel? { self.hotReloadView(id: "main_text_label") as? UILabel }
  private var optionImageView: UIImageView? { self.hotReloadView(id: "option_image_view") as? UIImageView }
  private var iconImageView: UIImageView? { self.hotReloadView(id: "icon_image_view") as? UIImageView }

  override func prepareForReuse() {
    super.prepareForReuse()
    self.nameLabel?.text = nil
    self.nameLabel?.isHidden = true
    self.atNameLabel?.text = nil
    self.atNameLabel?.isHidden = true
    self.timeAgoLabel?.text = nil
    self.timeAgoLabel?.isHidden = true
    self.mainTextLabel?.text = nil
    self.mainTextLabel?.isHidden = true
    self.iconImageView?.image = nil
    self.optionImageView?.image = nil
    self.optionImageView?.isHidden = true
  }

  func configure(user: TwitterTimelineModel) {
    if let name = user.name, !name.isEmpty {
      self.nameLabel?.text = name
      self.nameLabel?.isHidden = false
    }
    if let atName = user.atName, !atName.isEmpty {
      self.atNameLabel?.text = atName
      self.atNameLabel?.isHidden = false
    }
    if let timeAgo = user.timeAgo, !timeAgo.isEmpty {
      self.timeAgoLabel?.text = user.timeAgo
      self.timeAgoLabel?.isHidden = false
    }
    if let mainText = user.mainText, !mainText.isEmpty {
      self.mainTextLabel?.text = mainText
      self.mainTextLabel?.isHidden = false
    }
    if let urlStr = user.iconImageUrlStr, let url = URL.init(string: urlStr) {
      self.iconImageView?.kf.setImage(with: url)
    }
    if let urlStr = user.optionImageUrlStr, let url = URL.init(string: urlStr) {
      self.optionImageView?.isHidden = false
      self.optionImageView?.kf.setImage(with: url)
    }
  }
}
