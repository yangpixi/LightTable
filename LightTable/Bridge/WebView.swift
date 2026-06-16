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
    
    var onHandleResult: ((String) -> Void)?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = context.coordinator
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        
        if webView.url?.absoluteString != url.absoluteString && !webView.isLoading {
            webView.load(request)
        }
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var object: WebView
        
        init(_ object: WebView) {
            self.object = object
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            let script: String = ""
            
            webView.evaluateJavaScript(script) { (result, error) in
                
                // 如果发生错误
                if error != nil {
                    return
                }
                
                // 将result转换为String类型
                if let jsonString = result as? String {
                    self.object.onHandleResult?(jsonString)
                }
            }
        }
    }
    
}
