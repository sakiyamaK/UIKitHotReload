//
//  WebViewModelProtocol.swift
//  UIKitHotReload
//
//  Created by sakiyamaK on 2020/12/25.
//

import UIKit
import WebKit

public protocol WebViewModelProtocol: ViewModelProtocol {
  var _allowsBack: Bool? { get }
  var _canBack: Bool? { get }
  var _allowsLinkPreview: Bool? { get }
  var _canPreview: Bool? { get }
  var _customUserAgent: String? { get }
  var _customUA: String? { get }
  var requestURLStr: String? { get }
  func setupWebView(_ webView: WKWebView)
}

public extension WebViewModelProtocol {
  var urlStr: String { requestURLStr ?? "https://google.com" }
  var url: URL { URL(string: urlStr ) ?? URL(string: "https://google.com")! }
  var allowsBack: Bool { ([_allowsBack, _canBack].first(where: { $0 != nil }) as? Bool) ?? true }
  var allowsLinkPreview: Bool { ([_allowsLinkPreview, _canPreview].first(where: { $0 != nil }) as? Bool) ?? true }
  var customUserAgent: String? { [_customUserAgent, _customUA].first(where: { $0 != nil }) as? String }
  func setupWebView(_ webView: WKWebView) {
    webView.allowsBackForwardNavigationGestures = allowsBack
    webView.allowsLinkPreview = allowsLinkPreview
    if let customUserAgent = customUserAgent {
      webView.customUserAgent = customUserAgent
    }

    webView.load(URLRequest(url: url))
  }
}
