//
//  WebViewViewController.swift
//  GemBetApp
//
//  Created by user on 17.03.2021.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {
  
  private let urlString = "https://html5test.com/"
  
  @IBOutlet weak var progressView: UIProgressView!
  @IBOutlet weak var myWebView: WKWebView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    settingWebView()
  }
  
  private func settingWebView() {
    guard let url = URL(string: urlString) else { return }
    let request = URLRequest(url: url)
    myWebView.load(request)
    myWebView.allowsBackForwardNavigationGestures = true
    myWebView.navigationDelegate = self
    myWebView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "estimatedProgress" {
      progressView.progress = Float(myWebView.estimatedProgress)
    }
  }
  
  private func showProgressView() {
    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
      self.progressView.alpha = 1
    }, completion: nil)
  }
  
  private func hideProgressView() {
    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
      self.progressView.alpha = 0
    }, completion: nil)
  }
}

// MARK: - Extensions

extension WebViewViewController: WKNavigationDelegate {
  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    showProgressView()
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    hideProgressView()
  }
  
  func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    hideProgressView()
  }
}
