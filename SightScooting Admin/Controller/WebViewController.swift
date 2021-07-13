//
//  WebViewController.swift
//  SightScooting Admin
//
//  Created by Sarmad Ishfaq on 11/07/2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController , WKNavigationDelegate {

    
    lazy var webView: WKWebView = {
        let wv = WKWebView()
//        wv.uiDelegate = self
//        wv.navigationDelegate = self
    
        wv.translatesAutoresizingMaskIntoConstraints = false
        return wv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        
        let urlString = "https://sfe.solidenglish.com/"
        let request = URLRequest(url:URL(string: urlString)!)
        self.webView.load(request)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
