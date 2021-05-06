//
//  UITextView+type.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2020/09/27.
//

import Foundation
import UIKit

extension UITextView {
    enum TextViewCustomType {
        case main
    }
    
    func customizeTextView(_ type: TextViewCustomType) {
        switch type {
        case .main:
            self.backgroundColor = UIColor.clear
            self.textColor = UIColor.driftWood
            self.font = UIFont.systemFont(ofSize: 15)
        }
    }
}
