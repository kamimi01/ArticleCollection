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
    var favoriteStatusList: [Bool] = []
}
