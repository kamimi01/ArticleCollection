//
//  UIImageView+type.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2020/09/28.
//

import Foundation
import UIKit

extension UIImageView {
    enum ImageCustomType {
        case main
        case urlShow
    }
    
    func customizeImage(_ type: ImageCustomType, _ imageName: String, _ imageUrl: String) {
        switch type {
        case .main:
            self.layer.cornerRadius = self.frame.height / 2
            self.image = UIImage(named: imageName)
        case .urlShow:
            self.layer.cornerRadius = self.frame.height / 2
            guard let url = URL(string: imageUrl) else {
                self.image = UIImage(named: "noUserImage")
                return
            }
            let imageLoader = ImageLoader()
            imageLoader.load(url: url) { [weak self] (image) in
                guard let self = self,
                      let image = image
                else {
                    DispatchQueue.main.async {
                        self?.image = UIImage(named: "noUserImage")
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}
