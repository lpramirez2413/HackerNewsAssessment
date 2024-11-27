//
//  WebContainerView.swift
//  HackerNewsAssessment
//
//  Created by Luis Perez on 25/11/24.
//

import SwiftUI
import WebKit

struct WebContainerView: UIViewRepresentable {
 
    let webView: WKWebView
    let url: String
    
    init(url: String) {
        webView = WKWebView(frame: .zero)
        self.url = url
    }
    
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: url) else { return }
        webView.load(URLRequest(url: url))
    }
}
