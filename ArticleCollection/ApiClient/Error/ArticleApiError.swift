//
//  ArticleApiError.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2021/05/03.
//

import Foundation

struct ArticleApiError: Decodable, Error {
    let message: String
    let type: String
}
