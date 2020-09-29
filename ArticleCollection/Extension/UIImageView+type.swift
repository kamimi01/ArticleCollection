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
    }
    
    func customizeImage(_ type: ImageCustomType, _ imageName: String) {
        switch type {
        case .main:
            self.layer.cornerRadius = self.frame.height / 2
            self.image = UIImage(named: imageName)
        }
    }
}
