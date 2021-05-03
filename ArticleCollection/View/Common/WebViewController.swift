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
    
    // シングルトンのインスタンスを作成する
    let articleStateManager: ArticleStateManager = ArticleStateManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        
        let articleUrl = articleStateManager.articleUrl

        if let url = NSURL(string: articleUrl) {
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
