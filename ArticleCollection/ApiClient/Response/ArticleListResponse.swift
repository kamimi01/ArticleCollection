//
//  Article.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2020/09/30.
//

import Foundation

struct ArticleListResponse: Decodable {
    let service: String
    let title: String
    let userName: String
    let likesCount: Int
    let profileImageUrl: String
    let url: String
    let createdDate: String
}
