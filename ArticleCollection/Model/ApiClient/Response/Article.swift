//
//  Article.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2020/09/30.
//

import Foundation
import RealmSwift

struct Article: Decodable {
    let id: String
    let service: String
    let title: String
    let userName: String
    let likesCount: Int
    let profileImageUrl: String
    let url: String
    let createdDate: String
}

class ArticleForRealm: Object {
    // 管理用 ID。プライマリーキー
    @objc dynamic var articleId = ""
    @objc dynamic var id = ""
    @objc dynamic var service: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var userName: String = ""
    @objc dynamic var likesCount: Int = 0
    @objc dynamic var profileImageUrl: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var createdDate: String = ""
    @objc dynamic var createdAt: Date = Date()
    
    /**
     id をプライマリーキーとして設定
     */
    override static func primaryKey() -> String? {
        return "articleId"
    }
}

class ArticleForHome: NSObject {
    var id: String
    var service: String
    var title: String
    var userName: String
    var likesCount: Int
    var profileImageUrl: String
    var url: String
    var createdDate: String
    var isFavorite: Bool = false

    init(article: [String: Any], favoriteIdList: [String]) {
        self.id = article["id"] as! String
        self.service = article["service"] as! String
        self.title = article["title"] as! String
        self.userName = article["userName"] as! String
        self.likesCount = article["likesCount"] as! Int
        self.profileImageUrl = article["profileImageUrl"] as! String
        self.url = article["url"] as! String
        self.createdDate = article["createdDate"] as! String

        if favoriteIdList.contains(article["id"] as! String) {
            self.isFavorite = true
        }
    }
}
