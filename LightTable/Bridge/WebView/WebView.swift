//
//  WebVeiew.swift
//  LightTable
//
//  Created by 空白 on 2026/6/14.
//  由于SwiftUi暂未提供原生WebView支持，所以需要一个bridge来桥接UiKit中的WKWebKit

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    var webViewController: WebViewController
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        
        webView.allowsBackForwardNavigationGestures = true
        webViewController.webView = webView
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        
        if webView.url?.absoluteString != url.absoluteString && !webView.isLoading {
            webView.load(request)
        }
    }
    
}
