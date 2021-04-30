//
//  ArticleTableViewCell.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2020/09/28.
//

import UIKit
import Lottie

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
    
    //AnimationViewの宣言
    var animationView = AnimationView()

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    //アニメーションの準備
    private func addAnimationView() {

        //アニメーションファイルの指定
        animationView = AnimationView(name: "heartAnimation")

        //アニメーションの位置指定（画面中央）
        animationView.frame = CGRect(x: articleTableView.frame.size.width - 93, y: 90, width: 50, height: 50)
        print(articleTableView.frame.size.width)
        print(articleTableView.frame.size.height - 10)

        //アニメーションのアスペクト比を指定＆ループで開始
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()

        //ViewControllerに配置
        articleTableView.addSubview(animationView)
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
        
        //アニメーション表示
//        addAnimationView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
