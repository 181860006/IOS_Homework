//
//  WebKit.swift
//  NJUNews
//
//  Created by 陈劭彬 on 2020/12/28.
//

import UIKit
import WebKit

class WebView: UIViewController
{
    @IBOutlet weak var webview: WKWebView!
    var html = ""
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        loadURL()
    }
    func loadURL()
    {
        if let url = URL(string: html)
        {
            let request = URLRequest(url: url)
            webview.load(request)
        }
    }
}
