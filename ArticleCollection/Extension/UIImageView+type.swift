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
            self.frame = CGRect(x: 50, y: 50, width: 60, height: 60)
            self.image = UIImage(named: imageName)
        }
    }
}
