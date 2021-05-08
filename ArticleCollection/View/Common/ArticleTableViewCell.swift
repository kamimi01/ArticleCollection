//
//  ArticleTableViewCell.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2020/09/28.
//

import UIKit
import FirebaseAnalytics

protocol ArticleCellDelegate {
    func reloadCell(index: IndexPath)
}

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var articleTableView: UIView!
    @IBOutlet weak var siteNameLabel: UILabel!
    @IBOutlet weak var articleNameLabel: UILabel!
    @IBOutlet weak var goodNameLabel: UILabel!
    @IBOutlet weak var goodNumLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var postedLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    var delegte: ArticleCellDelegate?
    var index: IndexPath!
    
    // Realmアクセス用のインスタンスを作成する
    let realmAccess = RealmAccess()
    
    // シングルトンのインスタンスを作成する
    let articleStateManager: ArticleStateManager = ArticleStateManager.shared

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    private func setup() {
        backgroundColor = UIColor.white

        // 各ラベルの設定
        siteNameLabel.textColor = UIColor.driftWood
        articleNameLabel.textColor = UIColor.boldGray
        articleNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        goodNameLabel.textColor = UIColor.gray
        goodNumLabel.textColor = UIColor.gray
        createdDateLabel.textColor = UIColor.gray
        postedLabel.textColor = UIColor.gray
    
        // 記事名の最大表示行数の設定
        articleNameLabel.numberOfLines = 2

        // ハートアイコンのタップ検知
        // タップ検知のためisUserInteractionEnabledをtrueに
        favoriteImageView.isUserInteractionEnabled = true
        // タップ時イベント設定
        favoriteImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageViewTapped)))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // ImageViewタップ時のイベント
    @objc func imageViewTapped(sender:UITapGestureRecognizer){
        // 記事情報を取得する
        let articleInfo = ArticleStateManager.shared.articleList
        let article = articleInfo[index[1]]

        let isHomeScreen = articleStateManager.isHomeScreen
        
        if isHomeScreen {
            // ホーム画面の処理
            // お気に入り状態の切り替え
            print("タップされたのは：", index)
            
            var favoriteStatus = articleStateManager.articleList[index[1]]["isFavorite"] as! Bool
            
            // タップ時のお気に入り状態がfalseの場合
            if !favoriteStatus {
                // Realmの登録
                // Realmにデータを保存する
                let result = realmAccess.save(article)
                
                if result {
                    favoriteImageView.image = UIImage(named: "heartActive")
                } else {
                    favoriteImageView.image = UIImage(named: "heartInactive")
                }

                // イベント収集
                var params: [String : Any] = [:]
                params[AnalyticsParameterItemID] = "registerFavorite"
                params[AnalyticsParameterItemName] = "お気に入りに登録"

                Analytics.logEvent(AnalyticsEventSelectContent, parameters: params)
            } else {
                // Realmからデータを削除する
                let result = realmAccess.removeByArticleInfo(article)
                
                if result {
                    favoriteImageView.image = UIImage(named: "heartInactive")
                }
                
                // イベント収集
                var params: [String : Any] = [:]
                params[AnalyticsParameterItemID] = "unregisterFavorite"
                params[AnalyticsParameterItemName] = "お気に入りから削除"

                Analytics.logEvent(AnalyticsEventSelectContent, parameters: params)
            }
            
            favoriteStatus = !favoriteStatus

            print("タップ後：", favoriteStatus)
            
            // 共有オブジェクトに保存
            articleStateManager.articleList[index[1]]["isFavorite"] = favoriteStatus
        } else {
            // お気に入り画面の処理
            // お気に入り状態の切り替え
            print("タップされたのは：", index)
            
            var favoriteStatusListForMyArticleCell = articleStateManager.favoriteStatusListForFavorites

            favoriteStatusListForMyArticleCell[index[1]] = !favoriteStatusListForMyArticleCell[index[1]]
            
            print("タップ後：", favoriteStatusListForMyArticleCell[index[1]])
            
            // 共有オブジェクトに保存
            articleStateManager.favoriteStatusListForFavorites[index[1]] = favoriteStatusListForMyArticleCell[index[1]]
            print(favoriteStatusListForMyArticleCell)
        }
        delegte?.reloadCell(index: index)
    }
}
