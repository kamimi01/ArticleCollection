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
    
    func setUnderLine() {
        // 枠線を非表示にする
        borderStyle = .none
        let underline = UIView()
        // heightにはアンダーラインの高さを入れる
        underline.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: 1.0)
        // 枠線の色
        underline.backgroundColor = .white
        addSubview(underline)
        // 枠線を最前面に
        bringSubviewToFront(underline)
    }
    
    func customizeTextField(_ type: TextFieldCustomType, _ placeholderText: String) {
        switch type {
        case .main:
            self.backgroundColor = UIColor.clear
            self.textColor = UIColor.white
            self.tintColor = UIColor.white

            self.setUnderLine()

            self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            self.font = UIFont.systemFont(ofSize: 20)
            self.returnKeyType = .done
        }
    }
}
