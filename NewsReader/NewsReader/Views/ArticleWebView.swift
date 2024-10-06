//
//  ArticleDetailView.swift
//  NewsReader
//
//  Created by Roshan yadav on 06/10/24.
//

import SwiftUI
import WebKit

struct ArticleWebView: View {
    let articleUrl: URL
    @State private var errorMessage: String = ""
    var body: some View {
        VStack {
            if !errorMessage.isEmpty {
                Text("\(errorMessage.capitalized)")
            }else {
                WebView(errorMessage: $errorMessage, url: articleUrl)
            }
            
        }
            .navigationBarTitleDisplayMode(.inline)
    }
}


struct WebView: UIViewRepresentable {
    @Binding var errorMessage: String
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func makeCoordinator() -> NavigationCoordinator {
        NavigationCoordinator(self)
    }
    
    class NavigationCoordinator: NSObject, WKNavigationDelegate {
            var parent: WebView
            
            init(_ parent: WebView) {
                self.parent = parent
            }
            
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: any Error) {
            parent.errorMessage = error.localizedDescription
        }
            
            func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
                parent.errorMessage = ""
            }
            
            func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
                parent.errorMessage = error.localizedDescription
                
            }
        }
}
