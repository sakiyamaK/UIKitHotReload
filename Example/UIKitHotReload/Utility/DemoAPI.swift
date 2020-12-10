//
//  DemoAPI.swift
//  UIKitHotReload_Example
//
//  Created by sakiyamaK on 2020/12/10.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

final class DemoAPI {
  static let shared = DemoAPI()
  private init() { }

  private let decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
  }()

  func getTwitterTimelines(completion: ((Result<[TwitterTimelineModel], Error>) -> Void )? = nil) {
    guard let path = Bundle.main.path(forResource: "twitter_timelines", ofType: "json") else {
      let error = NSError.init(domain: "no file", code: 120, userInfo: nil)
      completion?(.failure(error))
      return
    }
    do {
      let fileUrl = URL(fileURLWithPath: path)
      let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
      let timelines = try decoder.decode([TwitterTimelineModel].self, from: data)
      completion?(.success(timelines))
    } catch let error {
      completion?(.failure(error))
    }
  }

}
