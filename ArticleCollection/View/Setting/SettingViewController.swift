//
//  SettingViewController.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2020/09/27.
//

import UIKit
import SVProgressHUD
import FirebaseAnalytics

class SettingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    let sectionNames = ["設定", "その他"]
    let appSettingKind = [["ユーザー名", "全てのお気に入り登録を削除"], ["このアプリについて"]]
    let cellHeight = 50
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    // ログイン画面で入力したユーザー名の取得
    let userName = UserDefaults.standard.string(forKey: "userName")
    let displayContent = [[UserDefaults.standard.string(forKey: "userName"), ""], [""]]
    
    // シングルトンのインスタンスを作成する
    let articleStateManager: ArticleStateManager = ArticleStateManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // イベント収集
        // 画面名を計測する
        Analytics.logEvent(
            AnalyticsEventScreenView,
            parameters: [
                AnalyticsParameterScreenName: "SettingScreen"
            ]
        )
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableViewHeight.constant = CGFloat(tableView.contentSize.height)
    }
    
    private func setup() {
        // view全体の設定
        view.backgroundColor = UIColor.mushRoom
        
        // ナビゲーションバーの設定
        let navBar = self.navigationController?.navigationBar
        navBar?.barTintColor = UIColor.mushRoom
        navBar?.titleTextAttributes = [
            .foregroundColor: UIColor.boldGray,
            .font: UIFont(name: "HiraMaruProN-W4", size: 17)!
        ]
        
        // ナビゲーションバーに下線を加える
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: navBar?.frame.size.height ?? 50 - 1, width: self.view.frame.width, height: 1)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        navBar?.layer.addSublayer(bottomLine)
        
        // tableViewの設定
        tableViewSetUp()
        
        // バージョンセルの設定
        versionLabel.textColor = UIColor.gray
        versionLabel.text = "バージョン " + version
        
        articleStateManager.isHomeScreen = false
    }
    
    private func tableViewSetUp() {
        tableView.delegate = self
        tableView.dataSource = self
        
        // xibの登録
        let nib = UINib(nibName: "AppSettingTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "AppSettingTableViewCell")
        
        tableView.rowHeight = CGFloat(cellHeight)
        tableView.backgroundColor = UIColor.mushRoom
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }
}

// - MARK: UITableViewDelegate
extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appSettingKind[section].count
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.mushRoom
        
        let header = view as? UITableViewHeaderFooterView
        header?.textLabel?.textColor = UIColor.gray
        header?.textLabel?.font = UIFont(name: "HiraginoSans-W3", size: 13)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexRow = indexPath.row
        let section = indexPath.section
        
        switch (section, indexRow) {
        case (0, 0):
            // アラート画面を表示する
            showAlert()
        case (0, 1):
            showAlertForDeleteAllFovorites()
        case (1, 0):
            print("遷移する")
            
            Transition.transitionPushDestination(self, "AppInfo")
        default:
            print("選択された行番号：", section, indexRow)
        }
    }
    
    // アラート画面を表示する
    private func showAlert() {
        let alert = UIAlertController.doubleBtnAlertWithTitle(title: "別のユーザーに\n切り替えますか？", message: "", okActionTitle: "OK", otherBtnTitle: "キャンセル", completion: {
            // ログイン画面に戻る
            Transition.transitionDestination(self, "Login", .fullScreen)
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showAlertForDeleteAllFovorites() {
        let alert = UIAlertController.doubleBtnAlertWithTitle(title: "全てのお気に入り記事の\n登録情報を削除しますか？", message: "", okActionTitle: "OK", otherBtnTitle: "キャンセル", completion: {
            // イベント収集
            var params: [String : Any] = [:]
            params[AnalyticsParameterItemID] = "deleteAllFavorites"
            params[AnalyticsParameterItemName] = "全お気に入り記事削除"

            Analytics.logEvent(AnalyticsEventSelectContent, parameters: params)

            // 全て削除する
            // Realmアクセス用のインスタンスを作成する
            let realmAccess = RealmAccess()
            
            let result = realmAccess.deleteAll()

            var favoriteArticles = self.articleStateManager.favoriteArticleList
            for (index, _) in favoriteArticles.enumerated() {
                    // ホーム画面用記事情報の共有オブジェクトのお気に入りフラグを全てfalseに更新する
                favoriteArticles[index]["isFavorite"] = false
            }
            self.articleStateManager.favoriteArticleList = favoriteArticles

            if result {
                SVProgressHUD.showSuccess(withStatus: "削除が完了しました")
                SVProgressHUD.dismiss(withDelay: 1.0)
                return
            }
            SVProgressHUD.showError(withStatus: "削除に失敗しました")
            SVProgressHUD.dismiss(withDelay: 3)
        })
        self.present(alert, animated: true, completion: nil)
    }
}

// - MARK: UITableViewDataSource
extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionNames[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppSettingTableViewCell", for: indexPath ) as! AppSettingTableViewCell
        
        cell.usernameLabel.text = appSettingKind[indexPath.section][indexPath.row]
        
        
        cell.usernameNowLabel.text = displayContent[indexPath.section][indexPath.row]
        
        cell.selectionStyle = .none
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return cell
    }
}
