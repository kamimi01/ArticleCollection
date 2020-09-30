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
        view.addBackground(name: "home")
        
        // アプリタイトルの設定
        appTitleLabel.textColor = UIColor.white
        appTitleLowLabel.textColor = UIColor.white
        
        // ユーザー名入力欄の設定
        usernameTextField.customizeTextField(.main, " ユーザー名")
        
        // 注意書きの設定
        attensionTextView.customizeTextView(.main)
        
        // はじめるボタンの設定
        nextButton.customizeButton(.mainActive, "はじめる")
    }
    
    // 画面外をタップするとキーボードが閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // アラート画面を表示する
    private func showAlert() {
        let alert = UIAlertController.singleBtnAlertWithTitle(title: "ユーザー名を\n入力してください。", message: "", okActionTitle: "OK", completion: {})
        self.present(alert, animated: true, completion: nil)
    }
    
    // はじめるボタンタップ時の挙動
    @IBAction func nextButtionTap(_ sender: Any) {
        if usernameTextField.text!.isEmpty {
            showAlert()
        }
        
        // 入力したユーザー名の取得
        let userName = usernameTextField.text ?? ""
        
        // ユーザー名をUserdefaultにセット
        UserDefaults.standard.set(userName, forKey: "userName")
        
        // Tabbar画面に遷移
        Transition.transitionDestination(self, "TabBar", .fullScreen)
    }
}
