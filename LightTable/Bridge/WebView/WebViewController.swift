//
//  WebViewController.swift
//  LightTable
//
//  Created by 空白 on 2026/6/16.
//

import SwiftUI
import WebKit

class WebViewController {
    weak var webView: WKWebView?
    
    func runCustomJS(_ script: String, completion: ((Any?, Error?) -> Void)? = nil) {
        // 确保实例存在后再执行
        guard let webView = self.webView else {
            print("WebView 实例不存在或已释放")
            return
        }
        
        webView.evaluateJavaScript(script) { result, error in
            if let error = error {
                print("JS 执行出错: \(error.localizedDescription)")
            } else {
                print("JS 执行成功")
            }
            completion?(result, error)
        }
    }
}
