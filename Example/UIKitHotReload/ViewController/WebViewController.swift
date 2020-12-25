//
//  WebViewController.swift
//  UIKitHotReload_Example
//
//  Created by sakiyamaK on 2020/12/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import UIKitHotReload
import WebKit

final class WebViewController: UIViewController {

  private var webView: WKWebView? { self.view.hotReloadView(id: "webview") as? WKWebView }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.loadHotReload(dirName: "views", ymlFileName: "web") { result in
      switch result {
      case .failure(let error):
        print(error.localizedDescription)
      default:
        self.webView?.uiDelegate = self
        self.webView?.navigationDelegate = self
        break
      }
    }
  }
}

extension WebViewController: WKNavigationDelegate {

}

extension WebViewController: WKUIDelegate {

}
