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
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        print(data)

        article.articleId = NSUUID().uuidString
        article.id = data["id"] as! String
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
    
    func removeByIdAndService(_ data: [String: Any]) -> Bool {
        print(data)
        
        let id = data["id"] as! String
        let service = data["service"] as! String
        
        let targetArticle = realm.objects(ArticleForRealm.self)
            .filter("id == %@ && service == %@", id, service)

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
    
    func readAll() -> [[String: Any]] {
        var articles: [[String: Any]] = []
        
        // Realmから全記事情報を取得する
        let articlesRealmObject = realm.objects(ArticleForRealm.self).sorted(byKeyPath: "createdAt", ascending: false)
        
        for article in articlesRealmObject {
            // 記事の情報を格納
            articles.append([
                "id": article.id,
                "service": article.service,
                "title": article.title,
                "userName": article.userName,
                "likesCount": article.likesCount,
                "profileImageUrl": article.profileImageUrl,
                "url": article.url,
                "createdDate": article.createdDate,
                "isFavorite": true
            ])
        }
        
        print(articles)
        
        return articles
    }
    
    func deleteAll() -> Bool {
        
        // articleIdとcreatedAt以外の値が一致しているデータを削除対象とする
        let allArticle = realm.objects(ArticleForRealm.self)
        
        print("削除対象は：", allArticle)

        do {
            try realm.write() {
                realm.delete(allArticle)
            }
            return true
        } catch {
            print("Realm Error")
        }
        return false
    }
}
