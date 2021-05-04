//
//  ArticleResponse.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2021/05/03.
//

import Foundation

struct ArticleResponse<ArticleContent: Decodable>: Decodable {
    let articleContents: [ArticleContent]
}
