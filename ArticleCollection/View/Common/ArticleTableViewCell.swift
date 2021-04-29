//
//  ArticleTableViewCell.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2020/09/28.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var siteNameLabel: UILabel!
    @IBOutlet weak var articleNameLabel: UILabel!
    @IBOutlet weak var goodNameLabel: UILabel!
    @IBOutlet weak var goodNumLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var postedLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
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
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
