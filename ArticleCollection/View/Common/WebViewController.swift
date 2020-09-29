//
//  WebViewController.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2020/09/29.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var refreshItem: UIBarButtonItem!
    @IBOutlet weak var closeItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        if let url = NSURL(string: "https://www.google.com") {
                    let request = NSURLRequest(url: url as URL)
                    webView.load(request as URLRequest)
        }
        view.backgroundColor = UIColor.mushRoom
        
        // toolbarの色の設定
        toolBar.barTintColor = UIColor.mushRoom
        toolBar.tintColor = UIColor.gray

    }
    
    // リフレッシュボタンをタップ
    @IBAction func refreshItemTap(_ sender: Any) {
        webView.reload()
    }
    
    // webviewを閉じる
    @IBAction func closeItemTap(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
