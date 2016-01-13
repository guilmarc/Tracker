//
//  WebViewController.swift
//  Tracker
//
//  Created by Marco Guilmette on 2016-01-12.
//  Copyright © 2016 Infologique. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.delegate = self
        
        self.webView.hidden = true
        
        self.webView.loadRequest((NSURLRequest(URL: NSURL(string: "http://www.personalconsultboard.com/Default.aspx")!)))
    }
    
    
    func webViewDidFinishLoad(webView: UIWebView) {
        self.webView.hidden = false
    }
}
