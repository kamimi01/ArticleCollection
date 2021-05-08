//
//  FavoriteArticleViewController.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2020/09/29.
//

import UIKit
import SVProgressHUD
import FirebaseAnalytics

class FavoriteArticleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ArticleCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noArticlesView: NoArticles!

    // シングルトンのインスタンスを作成する
    let articleStateManager: ArticleStateManager = ArticleStateManager.shared
    
    // Realmアクセス用のインスタンスを作成する
    let realmAccess = RealmAccess()
    
    // 記事情報を取得する
    var articleInfo: [[String: Any]] = []

    let cellHeight = 157
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    // 画面再表示
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setup()
 
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // イベント収集
        // 画面名を計測する
        Analytics.logEvent(
            AnalyticsEventScreenView,
            parameters: [
                AnalyticsParameterScreenName: "FavoriteScreen"
            ]
        )
    }
    
    private func setup() {
        // HUDを表示する
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show()

        // ナビゲーションバーの設定
        let navBar = self.navigationController?.navigationBar
        navBar?.barTintColor = UIColor.onion
        navBar?.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "HiraMaruProN-W4", size: 17)!
        ]
        
        // Realm内のデータを取得する
        let favoriteArticleLists = realmAccess.readAll()
        
        if favoriteArticleLists.isEmpty {
            // Realm内のデータが空の場合は記事がない画面を表示
            noArticlesView.isHidden = false
            noArticlesView.animationView.play()
            SVProgressHUD.dismiss()
            return
        }
        noArticlesView.isHidden = true
        
        // tableViewの設定
        tableViewSetUp()

        tableView.backgroundColor = UIColor.white

        // 共有オブジェクトに格納
        articleStateManager.favoriteArticleList = favoriteArticleLists
        articleInfo = articleStateManager.favoriteArticleList
        
        articleStateManager.favoriteStatusListForFavorites = [Bool](repeating: true, count: articleInfo.count)
        
        articleStateManager.isHomeScreen = false
        
        SVProgressHUD.dismiss()
    }
    
    private func tableViewSetUp() {
        tableView.delegate = self
        tableView.dataSource = self
        
        // xibの登録
        let nib = UINib(nibName: "ArticleTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ArticleTableViewCell")
        
        tableView.rowHeight = CGFloat(cellHeight)
        tableView.separatorInset = UIEdgeInsets.zero
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath ) as! ArticleTableViewCell
        
        let indexRow = indexPath.row
        
        let article = articleInfo[indexRow]

        let serviceName = article["service"] as? String ?? ""
        var articleMetaInfo = ArticleMetaInfo.init(siteNameType: .qiita)

        switch serviceName {
        case "qiita":
            articleMetaInfo = ArticleMetaInfo.init(siteNameType: .qiita)
        case "note":
            articleMetaInfo = ArticleMetaInfo.init(siteNameType: .note)
        case "hatena":
            articleMetaInfo = ArticleMetaInfo.init(siteNameType: .hatenaBlog)
        default:
            articleMetaInfo = ArticleMetaInfo.init(siteNameType: .qiita)
        }
        
        cell.siteNameLabel.text = articleMetaInfo.siteName
        cell.goodNameLabel.text = articleMetaInfo.likeName
        cell.siteNameLabel.customizeLabel(.tag, article["service"] as? String ?? "")
        cell.articleNameLabel.text = article["title"] as? String

        let createdDateString = article["createdDate"] as? String ?? "2020-01-01T20:32:58+09:00"
        
        cell.createdDateLabel.text = DateFormat.formatDateToString(.full, createdDateString) + "に"

        cell.goodNumLabel.text = String(article["likesCount"] as? Int ?? 100)
        cell.iconImageView.customizeImage(.urlShow, "", article["profileImageUrl"] as? String ?? "")

        cell.delegte = self
        cell.index = indexPath
        
        print("tableviewどこが呼ばれてる？", articleStateManager.favoriteStatusListForFavorites[indexRow])
        
        if articleStateManager.favoriteStatusListForFavorites[indexRow] {
            print("表示切り替えが呼ばれる")
            cell.favoriteImageView.image = UIImage(named: "heartActive")

            // イベント収集
            var params: [String : Any] = [:]
            params[AnalyticsParameterItemID] = "registerFavorite"
            params[AnalyticsParameterItemName] = "お気に入りに登録"

            Analytics.logEvent(AnalyticsEventSelectContent, parameters: params)
        } else {
            // Realmからデータを削除する
            let result = realmAccess.removeByArticleInfo(article)
            
            if result {
                cell.favoriteImageView.image = UIImage(named: "heartInactive")
            }
            
            // イベント収集
            var params: [String : Any] = [:]
            params[AnalyticsParameterItemID] = "unregisterFavorite"
            params[AnalyticsParameterItemName] = "お気に入りから削除"

            Analytics.logEvent(AnalyticsEventSelectContent, parameters: params)
        }

        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexRow = indexPath.row
        let article = articleInfo[indexRow]
        
        // イベント収集
        var params: [String : Any] = [:]
        params[AnalyticsParameterItemID] = "webViewDisplay"
        params[AnalyticsParameterItemName] = "WebView表示"

        Analytics.logEvent(AnalyticsEventSelectContent, parameters: params)

        // 表示するURLを次の画面へ渡す
        articleStateManager.articleUrl = article["url"] as? String ?? ""
        // webViewに遷移する
        Transition.transitionDestination(self, "WebView", .fullScreen)
    }
    
    func reloadCell(index: IndexPath) {
        print("ここでは", articleStateManager.favoriteStatusListForFavorites)
        tableView.reloadRows(at: [index], with: .none)
    }

}
