//
//  WebViewController.swift
//  sesac-trendMedia
//
//  Created by MIN SEONG KIM on 2022/08/09.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    //MARK: - Properties
    var key = ""
    lazy var destinationURL: String = "https://www.youtube.com/watch?v=\(key)"
    @IBOutlet weak var webView: WKWebView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        openWebPage(to: destinationURL)
    }
    
    //MARK: - Helpers
    func openWebPage(to urlStr: String) {
        guard let url = URL(string: urlStr) else {
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
