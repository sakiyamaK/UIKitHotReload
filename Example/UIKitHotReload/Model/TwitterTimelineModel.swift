//
//  TwitterTimelineModel.swift
//  UIKitHotReload_Example
//
//  Created by sakiyamaK on 2020/12/10.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

final class TwitterTimelineModel: Codable {
  var id: Int
  var name: String?
  var atName: String?
  var timeAgo: String?
  var mainText: String?
  var iconImageUrlStr: String?
  var optionImageUrlStr: String?
}
