//
//  RealmAccess.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2021/05/04.
//

import Foundation
import RealmSwift

class RealmAccess {
    let realm = try! Realm()
    
    func save(_ data: [String: Any]) -> Bool {
        let article = ArticleForRealm()
        
        print(data)

        article.articleId = NSUUID().uuidString
        article.createdAt = Date()
        // FIXME
        article.service = data["service"] as! String
        article.title = data["title"] as! String
        article.userName = data["userName"] as! String
        article.likesCount = data["likesCount"] as! Int
        article.profileImageUrl = data["profileImageUrl"] as! String
        article.url = data["url"] as! String
        article.createdDate = data["createdDate"] as! String

        do {
            try realm.write() {
                realm.add(article)
            }
            print(Realm.Configuration.defaultConfiguration.fileURL!)
            return true
        } catch {
            print("Realm Error")
            
        }
        
        return false
    }
    
    func removeByArticleInfo(_ data: [String: Any]) -> Bool {
        print(data)
        
        let service = data["service"] as! String
        let title = data["title"] as! String
        let userName = data["userName"] as! String
        let likesCount = data["likesCount"] as! Int
        let profileImageUrl = data["profileImageUrl"] as! String
        let url = data["url"] as! String
        let createdDate = data["createdDate"] as! String
        
        // articleIdとcreatedAt以外の値が一致しているデータを削除対象とする
        let targetArticle = realm.objects(ArticleForRealm.self)
            .filter("service == %@ && title == %@ && userName == %@ && likesCount == %@ && profileImageUrl == %@ && url == %@ && createdDate == %@",
                    service, title, userName, likesCount, profileImageUrl, url, createdDate)
        
        print("削除対象は：", targetArticle)

        do {
            try realm.write() {
                realm.delete(targetArticle)
            }
            return true
        } catch {
            print("Realm Error")
        }
        return false
    }
}
