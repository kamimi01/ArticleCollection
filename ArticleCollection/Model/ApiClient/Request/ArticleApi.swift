//
//  ArticleApi.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2021/05/03.
//

import Foundation

final class ArticleApi {
    // APIのパスが増える場合はここに定義を追加していく
    struct ArticleList: ArticleRequest {
        let keyword: String
        
        // ArticleRequestが要求する連想型
        typealias Response = ArticleResponse<Article>
        
        var method: HttpMethod {
            return .get
        }
        
        var path: String {
            return ApiConfig.articlesPath
        }
        
        var queryItems: [URLQueryItem] {
            return [URLQueryItem(name: ApiConfig.articlesUserNamePram, value: keyword)]
        }
        
        var headers: [String: String] {
            return [
                ApiConfig.apiKeyHeader: apikey
            ]
        }
    }
}
