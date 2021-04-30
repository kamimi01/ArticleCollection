//
//  ArticleTableViewCell.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2020/09/28.
//

import UIKit
import Lottie

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
    var index:IndexPath!
    
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
        // お気に入り状態の切り替え
        // セルごとの状態を保持する方法がわからない
        // セルごとの状態をどうやってクラス間で共有するかがわからない
        print("タップされたのは：", index)
        
        var favoriteStatusListForMyArticleCell = articleStateManager.favoriteStatusList

        favoriteStatusListForMyArticleCell[index[1]] = !favoriteStatusListForMyArticleCell[index[1]]
        
        print("タップ後：", favoriteStatusListForMyArticleCell[index[1]])
        
        // 共有オブジェクトに保存
        articleStateManager.favoriteStatusList[index[1]] = favoriteStatusListForMyArticleCell[index[1]]
        print(favoriteStatusListForMyArticleCell)
        // セルの更新をviewcontrollerに移譲する
        delegte?.reloadCell(index: index)
    }
    
}
