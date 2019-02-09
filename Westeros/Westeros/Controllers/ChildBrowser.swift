//
//  ChildBrowser.swift
//  Westeros
//
//  Created by Alberto García-Muñoz on 07/02/2019.
//  Copyright © 2019 AlbGarciam. All rights reserved.
//

import UIKit
import WebKit

class ChildBrowser: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView! {
        didSet {
            spinner.style = .gray
        }
    }
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    let model: House
    
    init(house: House) {
        self.model = house
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        syncModelWithView()
    }
    
    func syncModelWithView() {
        title = model.name
        spinner.isHidden = false
        spinner.startAnimating()
        webView.load(URLRequest(url: model.wikiURL))
    }
}

extension ChildBrowser: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        spinner.stopAnimating()
        spinner.isHidden = true
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        switch navigationAction.navigationType {
        case .linkActivated, .formResubmitted, .formSubmitted:
            decisionHandler(.cancel)
        default:
            decisionHandler(.allow)
        }
    }
}
