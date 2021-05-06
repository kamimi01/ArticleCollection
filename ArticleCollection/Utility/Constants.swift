//
//  Constants.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2021/04/27.
//

struct ApiConfig {
    static let baseUrl = "https://f6fnqnhfxa.execute-api.ap-northeast-1.amazonaws.com/dev"
    static let articlesPath = "/articles"
    static let articlesUserNamePram = "userName"
    static let apiKeyHeader = "X-Api-Key"
}

class ArticleMetaInfo {
    // 記事サイトの種類
    enum siteNameType {
        case qiita
        case hatenaBlog
        case note
    }
    
    // プロパティ
    let siteName: String
    let likeName: String
    
    // 初期化
    init(siteNameType: siteNameType) {
        switch siteNameType {
        case .qiita:
            self.siteName = " Qiita "
            self.likeName = "LGTM"
        case .hatenaBlog:
            self.siteName = " はてなブログ "
            self.likeName = "いいね"
        case .note:
            self.siteName = " note "
            self.likeName = "スキ"
        }
    }
}
