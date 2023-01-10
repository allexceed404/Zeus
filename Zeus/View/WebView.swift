//
//  WebView.swift
//  Zeus
//
//  Created by Priyanshu Verma on 30/12/22.
//

import UIKit
import WebKit

class WebView: UIViewController, WKUIDelegate {
    var webView: WKWebView!
    var webURL: String?
    
    var urlLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        if let webURL {
            if let requestURL = URL(string: webURL) {
                let request = URLRequest(url: requestURL)
                webView.load(request)
            }
        }
    }
    
    fileprivate func setupView() {
        setupNavigationBar()
    }
    
    fileprivate func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = .systemYellow
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrowshape.backward.fill"), style: .plain, target: self, action: #selector(goBack))
        backButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = backButton
        
        let urlLabelItem = UIBarButtonItem(customView: urlLabel)
        self.navigationItem.rightBarButtonItem = urlLabelItem
    }
    
    override func loadView() {
        print(#function)
        
        urlLabel.text = webURL
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    @objc fileprivate func goBack() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.popViewController(animated: true)
    }
    
}
