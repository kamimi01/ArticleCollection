//
//  UIButton+type.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2020/09/27.
//

import Foundation
import UIKit

extension UIButton {
    enum ButtonCustomType {
        case mainActive
    }
    
    func customizeButton (_ type: ButtonCustomType, _ buttonName: String) {
        switch type {
        case .mainActive:
            self.backgroundColor = UIColor.onion
            self.setTitleColor(UIColor.white, for: .normal)
            self.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            self.setTitle(buttonName, for: .normal)
            self.isEnabled = true
            self.layer.cornerRadius = 15.0
        }
    }
}
