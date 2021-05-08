//
//  MyArticleViewController.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2020/09/28.
//

import UIKit
import RealmSwift
import FirebaseAnalytics

class MyArticleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ArticleCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    // シングルトンのインスタンスを作成する
    let articleStateManager: ArticleStateManager = ArticleStateManager.shared
    
    // Realmアクセス用のインスタンスを作成する
    let realmAccess = RealmAccess()

    // 記事情報を取得する
    var articleInfo = ArticleStateManager.shared.articleList
    
    let cellHeight = 157
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    // 画面再表示
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        articleStateManager.isHomeScreen = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // 値を取得し直す
        articleInfo = ArticleStateManager.shared.articleList
        
        // イベント収集
        // 画面名を計測する
        Analytics.logEvent(
            AnalyticsEventScreenView,
            parameters: [
                AnalyticsParameterScreenName: "HomeScreen"
            ]
        )
    }
    
    private func setup() {
        // ナビゲーションバーの設定
        let navBar = self.navigationController?.navigationBar
        navBar?.barTintColor = UIColor.onion
        navBar?.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "HiraMaruProN-W4", size: 17)!
        ]
        
        // tableViewの設定
        tableViewSetUp()

        tableView.backgroundColor = UIColor.white
        
        articleStateManager.isHomeScreen = true
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
        
        // 値を取得し直す
        articleInfo = ArticleStateManager.shared.articleList
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

        let isFavorite = article["isFavorite"] as! Bool
        print("お気に入り登録状態：", isFavorite)
        if (isFavorite) {
            cell.favoriteImageView.image = UIImage(named: "heartActive")
        } else {
            cell.favoriteImageView.image = UIImage(named: "heartInactive")
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
        tableView.reloadRows(at: [index], with: .none)
    }
}
