//
//  UITextField+type.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2020/09/27.
//

import Foundation
import UIKit

extension UITextField {
    enum TextFieldCustomType {
        case main
    }
    
    func customizeTextField(_ type: TextFieldCustomType, _ placeholderText: String) {
        switch type {
        case .main:
            self.backgroundColor = UIColor.white
            self.textColor = UIColor.driftWood
            self.tintColor = UIColor.driftWood
            self.borderStyle = UITextField.BorderStyle.none
            self.layer.cornerRadius = 15
            self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightDriftWood])
            self.font = UIFont.systemFont(ofSize: 20)
            self.returnKeyType = .done
        }
    }
}
