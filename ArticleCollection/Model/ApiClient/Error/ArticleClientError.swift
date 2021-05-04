//
//  ArticleClientError.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2021/05/03.
//

import Foundation

enum ArticleClientError: Error {
    // 通信に失敗
    case connectionError(Error)
    
    // レスポンスの解釈に失敗
    case responseParseError(Error)
    
    // APIからエラーレスポンスを受け取った
    case apiError(ArticleApiError)
}
