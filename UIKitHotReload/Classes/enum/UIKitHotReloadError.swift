//
//  UIKitHotReloadError.swift
//  UIKitHotReload
//
//  Created by sakiyamaK on 2020/12/28.
//

import Foundation

enum UIKitHotReloadError: String, Error {
  case notGettingDocuments, notFoundData, notFoundRootView, notFoundFile

  private var code: Int {
    switch self {
    case .notGettingDocuments:
      return 100
    case .notFoundData:
      return 110
    case .notFoundRootView:
      return 120
    case .notFoundFile:
      return 130
    }
  }

  private var domain: String { self.rawValue }

  var error: Error { NSError.init(domain: self.domain, code: self.code, userInfo: nil) }
}

