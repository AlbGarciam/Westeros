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
    private(set) var model: House
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(houseDidChanged(_:)),
                                               name: NSNotification.Name.houseDidChanged,
                                               object: nil) // Object which generates the notification, if nil is all objects
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func houseDidChanged(_ notification: Notification) {
        let userData = notification.userInfo
        guard let newModel = userData?[NotificationKeys.HouseDidChanged] as? House else { return }
        self.model = newModel
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
