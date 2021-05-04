//
//  ArticleRequest.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2021/05/03.
//

import Foundation

protocol ArticleRequest {
    associatedtype Response: Decodable

    var baseUrl: URL { get }
    var path: String { get }
    var method: HttpMethod { get }
    var queryItems: [URLQueryItem] { get }
    var headers: [String: String] { get }
}

extension ArticleRequest {
    var baseUrl: URL {
        return URL(string: ApiConfig.baseUrl)!
    }
    
    // クエリ文字列をベースURLに結合して、リクエストURLを作成する
    func buildUrlRequest() -> URLRequest {
        let url = baseUrl.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        switch method {
        case .get:
            components?.queryItems = queryItems
        default:
            fatalError("Unsupported method \(method)")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.url = components?.url
        urlRequest.httpMethod = method.rawValue
        headers.forEach {key, value in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        return urlRequest
    }
    
    func response(from data: Data, urlResponse: URLResponse) throws -> Response {
        let decoder = JSONDecoder()
        
        if case (200..<300)? = (urlResponse as? HTTPURLResponse)?.statusCode {
            // JSONからモデルをインスタンス化
            return try decoder.decode(Response.self, from: data)
        } else {
            throw try decoder.decode(ArticleApiError.self, from: data)
        }
    }
}
