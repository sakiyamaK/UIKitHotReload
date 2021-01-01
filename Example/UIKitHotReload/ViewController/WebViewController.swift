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
  private var indicator: UIActivityIndicatorView? { self.view.hotReloadView(id: "indicator") as? UIActivityIndicatorView }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.loadHotReload(dirName: "views", ymlFileName: "web") { result in
      switch result {
      case .failure(let error):
        print(error.localizedDescription)
      default:
        DispatchQueue.main.async {
          self.indicator?.startAnimating()
          self.webView?.uiDelegate = self
          self.webView?.navigationDelegate = self
        }
      }
    }
  }
}

extension WebViewController: WKNavigationDelegate {
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    webView.alpha = 1.0
    indicator?.isHidden = true
  }

}

extension WebViewController: WKUIDelegate {

}
