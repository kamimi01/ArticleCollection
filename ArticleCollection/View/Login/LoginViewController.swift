//
//  LoginViewController.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2020/09/27.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var appTitleLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var appTitleLatterLabel: UILabel!
    
    // シングルトンのインスタンスを作成する
    let articleStateManager: ArticleStateManager = ArticleStateManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // ユーザー名入力欄の設定
        usernameTextField.customizeTextField(.main, " ユーザー名")
    }
    
    private func setup() {
        // 全体の設定
        view.addBackground(name: "home")
        
        // アプリタイトルの設定
        appTitleLabel.textColor = UIColor.white
        appTitleLatterLabel.textColor = UIColor.white
        
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
    
    private func getArticles(userName: String) {
        // APIクライアントの生成
        let client = ArticleClient()
        
        // リクエストの発行
        let request = ArticleApi.ArticleList(keyword: userName)
        
        // 記事情報を格納していく
        var articleLists: [[String: Any]] = []
        
        let semaphore = DispatchSemaphore(value: 0)

        // リクエストの送信
        client.send(request: request) { result in
            switch result {
            case let .success(response):
                for article in response.articleContents {
                    // 記事の情報を格納
                    articleLists.append([
                        "service": article.service,
                        "title": article.title,
                        "userName": article.userName,
                        "likesCount": article.likesCount,
                        "profileImageUrl": article.profileImageUrl,
                        "url": article.url,
                        "createdDate": article.createdDate
                    ])
                }
                // 共有オブジェクトに格納する
                self.articleStateManager.articleList = articleLists
                print("取得できた：", self.articleStateManager.articleList)
            case let .failure(error):
                print(error)
            }
            
            semaphore.signal()
        }
        // signalが呼ばれるまで待機する
        semaphore.wait()
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
        
        // APIを呼び出す
        getArticles(userName: userName)
        
        // Tabbar画面に遷移
        Transition.transitionDestination(self, "TabBar", .fullScreen)
    }
}
