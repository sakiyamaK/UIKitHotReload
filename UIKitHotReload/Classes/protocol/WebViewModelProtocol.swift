//
//  WebViewModelProtocol.swift
//  UIKitHotReload
//
//  Created by sakiyamaK on 2020/12/25.
//

import UIKit
import WebKit

public protocol WebViewModelProtocol: ViewModelProtocol {
  var requestURLStr: String? { get }
  func setupWebView(_ webView: WKWebView)
}

public extension WebViewModelProtocol {
  var urlStr: String { requestURLStr ?? "https://google.com" }
  var url: URL { URL(string: urlStr ) ?? URL(string: "https://google.com")! }
  func setupWebView(_ webView: WKWebView) {
    webView.load(URLRequest(url: url))
  }
}
