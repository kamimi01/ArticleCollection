//
//  Article.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2020/09/30.
//

import Foundation
import RealmSwift

struct Article: Decodable {
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
