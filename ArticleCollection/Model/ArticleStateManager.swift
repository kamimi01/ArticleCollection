//
//  ArticleState.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2021/04/30.
//

import Foundation

// シングルトンパターンを使用し、常に1つのインスタンスのみが存在することを保証する
final public class ArticleStateManager {
    public static let shared = ArticleStateManager()
    private init() {}
    
    // お気に入りかどうかのフラグリスト
//    var favoriteStatusList: [Bool] = []
    
    // お気に入りかどうかのフラグリスト（お気に入りタブ用）
    var favoriteStatusListForFavorites: [Bool] = []
    
    // ホーム画面のセルタップかどうかを判定する
    var isHomeScreen = true
    
    // 記事情報
    var articleList: [[String: Any]] = []
    
    // お気に入りの記事情報
    var favoriteArticleList: [[String: Any]] = []
    
    // 記事のURL
    var articleUrl: String = ""
}
