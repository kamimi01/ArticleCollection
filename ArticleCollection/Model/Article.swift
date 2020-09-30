//
//  Article.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2020/09/30.
//

import Foundation
import UIKit

class Article {
    // 記事サイトの種類
    enum siteNameType {
        case qiita
        case hatenaBlog
    }
    
    // プロパティ
    let siteName: String
    let articleName: String
    let userName: String
    let goodName: String
    let goodNum: Int
    let userImage: UIImage
    
    // 初期化
    init(siteNameType: siteNameType, articleName: String, userName: String, goodNum: Int, userImage: UIImage) {

        self.articleName = articleName
        self.userName = userName
        self.goodNum = goodNum
        self.userImage = userImage
        
        switch siteNameType {
        case .qiita:
            self.siteName = "Qiita"
            self.goodName = "LGTM"
        case .hatenaBlog:
            self.siteName = "はてなブログ"
            self.goodName = "いいね"
        }
    }
}
