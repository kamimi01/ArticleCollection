//
//  LoginViewController.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2020/09/27.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var appTitleLabel: UILabel!
    @IBOutlet weak var appTitleLowLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var attensionTextView: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        // 全体の設定
        view.backgroundColor = UIColor.onion
        
        // アプリタイトルの設定
        appTitleLabel.textColor = UIColor.driftWood
        appTitleLowLabel.textColor = UIColor.driftWood
        
        // ユーザー名入力欄の設定
        usernameTextField.customizeTextField(.main, " ユーザー名")
        
        // 注意書きの設定
        attensionTextView.customizeTextView(.main)
        
        // はじめるボタンの設定
        nextButton.customizeButton(.mainActive, "はじめる→")
    }
    
    @IBAction func nextButtionTap(_ sender: Any) {
        Transition.transitionDestination(self, "TabBar", .fullScreen)
    }
}
