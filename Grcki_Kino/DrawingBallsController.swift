//
//  Izvlacenje.swift
//  Grcki_Kino
//
//  Created by Ivana Todorovic on 19/10/2020.
//

import UIKit
import WebKit

class DrawingBallsController: UIViewController {
    
    let webView = WKWebView()
    
    override func viewDidLoad() {
        webView.frame.size.width = UIScreen.main.bounds.width
    }
    
    override func loadView() {
        self.view = webView
        if let url = URL(string: "https://ds.opap.gr/web_kino/kinoIframe.html?link=https://ds.opap.gr/web_kino/kino/html/Internet_PRODUCTION/KinoDraw_201910.html&resolution=847x500") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    
}
