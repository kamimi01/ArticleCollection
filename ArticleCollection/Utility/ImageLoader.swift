//
//  ImageLoader.swift
//  ArticleCollection
//
//  Created by mikaurakawa on 2022/08/13.
//

import UIKit

final class ImageLoader {
    func load(url: URL, completion: @escaping (_ image: UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                completion(UIImage(data: data))
            }
        }
        task.resume()
    }
}
