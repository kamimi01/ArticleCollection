//
//  LoginViewController.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2020/09/27.
//

import UIKit
import SVProgressHUD
import FirebaseAnalytics

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var appTitleLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var appTitleLatterLabel: UILabel!
    
    // シングルトンのインスタンスを作成する
    let articleStateManager: ArticleStateManager = ArticleStateManager.shared
    
    var result = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // ユーザー名入力欄の設定
        usernameTextField.customizeTextField(.main, " ユーザー名")
        
        // イベント収集
        // 画面名を計測する
        Analytics.logEvent(
            AnalyticsEventScreenView,
            parameters: [
                AnalyticsParameterScreenName: "StartScreen"
            ]
        )
    }
    
    private func setup() {
        // 全体の設定
        view.addBackground(name: "home")
        
        // アプリタイトルの設定
        appTitleLabel.textColor = UIColor.white
        appTitleLatterLabel.textColor = UIColor.white
        
        // キーボードのリターンキーを押下した時の設定
        usernameTextField.delegate = self

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
    
    // API通信でエラーが起きた場合はアラート画面を表示する
    private func showAlertForApiError() {
        let alert = UIAlertController.singleBtnAlertWithTitle(title: "ユーザーか存在しないか表示できる記事がありません。\n違うユーザー名を入力してください。", message: "", okActionTitle: "OK", completion: {})
        self.present(alert, animated: true, completion: nil)
    }
    
    private func getArticles(userName: String) -> Bool {
        // Realmにアクセス
        let realmAccess = RealmAccess()
        let favoriteIdLists = realmAccess.readAll().map({ $0["id"] as! String })
        
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
                    let articleList = [
                        "id": article.id,
                        "service": article.service,
                        "title": article.title,
                        "userName": article.userName,
                        "likesCount": article.likesCount,
                        "profileImageUrl": article.profileImageUrl,
                        "url": article.url,
                        "createdDate": article.createdDate
                    ] as [String : Any]

                    let articleContent = ArticleForHome(article: articleList, favoriteIdList: favoriteIdLists)
                    // 記事の情報を格納
                    articleLists.append([
                        "id": articleContent.id,
                        "service": articleContent.service,
                        "title": articleContent.title,
                        "userName": articleContent.userName,
                        "likesCount": articleContent.likesCount,
                        "profileImageUrl": articleContent.profileImageUrl,
                        "url": articleContent.url,
                        "createdDate": articleContent.createdDate,
                        "isFavorite": articleContent.isFavorite
                    ])
                }
                // 共有オブジェクトに格納する
                self.articleStateManager.articleList = articleLists
                print("取得できた：", self.articleStateManager.articleList)
                self.result = true
            case let .failure(error):
                print(error)
                self.result = false
            }
            
            semaphore.signal()
        }
        // signalが呼ばれるまで待機する
        semaphore.wait()
        
        return result
    }
    
    // キーボードのリターンまたは始めるボタンタップ時の挙動
    private func startApp() {
        if usernameTextField.text!.isEmpty {
            showAlert()
            return
        }
        
        // HUDを表示する
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show()
        
        // 入力したユーザー名の取得
        let userName = usernameTextField.text ?? ""
        
        // ユーザー名をUserdefaultにセット
        UserDefaults.standard.set(userName, forKey: "userName")
        
        // APIを呼び出す
        let getArticlesApiResult = getArticles(userName: userName)
        
        if !getArticlesApiResult {
            showAlertForApiError()
            SVProgressHUD.dismiss()
            return
        }
        
        // Tabbar画面に遷移
        Transition.transitionDestination(self, "TabBar", .fullScreen)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        startApp()
        return true
    }
    
    // はじめるボタンタップ時の挙動
    @IBAction func nextButtionTap(_ sender: Any) {
        startApp()
    }
}
