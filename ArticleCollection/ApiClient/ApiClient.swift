//
//  ApiClient.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2021/04/27.
//

import Foundation

protocol Requestable {
    var url: String { get }
    var httpMethod: String { get }
    var headers: [String: String] { get }
}

extension Requestable {
    var urlRequest: URLRequest? {
        guard let url = URL(string: url) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        headers.forEach{ key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        return request
    }
}

struct ArticlesListApiRequest: Requestable {
    var url: String {
        return ApiConfig.baseUrl
    }
    
    var httpMethod: String {
        return "GET"
    }
    
    var headers: [String: String] {
        return [:]
    }
}

//class ApiClient {
//    func request(_ requestable: Requestable) {
//        guard let url = requestable.urlRequest else { return }
//
//        let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
//            if let data = data {
//                let articleInfo = try! JSONDecoder().decode(Article.self, from: data)
//                dump(articleInfo)
//            }
//        })
//        task.resume()
//    }
//}
