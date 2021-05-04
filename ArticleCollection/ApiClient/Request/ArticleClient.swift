//
//  ArticleClient.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2021/05/03.
//

import Foundation

class ArticleClient {
    private let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    func send<Request: ArticleRequest> (
        request: Request,
        completion: @escaping (Result<Request.Response,
                                      ArticleClientError>) -> Void) {
        // HTTPリクエストの送信
        let urlRequest = request.buildUrlRequest()
        let task = session.dataTask(with: urlRequest) {
            data, response, error in
            
            switch (data, response, error) {
            case (_, _, let error?):
                completion(Result(error: .connectionError(error)))
            case (let data?, let response?, _):
                print("データとレスポンスがある")
                print(response)
                print(data)
                do {
                    let response = try request.response(from: data, urlResponse: response)
                    print(response)
                    completion(Result(value: response))
                } catch let error as ArticleApiError {
                    completion(Result(error: .apiError(error)))
                } catch {
                    completion(Result(error: .responseParseError(error)))
                }
            default:
                fatalError("invalid response combination \(data!), \(response!), \(error!).")
            }
        }
        
        task.resume()
    }
}
