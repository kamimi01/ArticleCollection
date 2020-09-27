//
//  UIAlertController+type.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2020/09/27.
//

import Foundation
import UIKit

extension UIAlertController {
    
    public class func singleBtnAlertWithTitle(title: String, message: String, okActionTitle: String, completion: (() -> Void)?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okActionTitle, style: .default) {
            _ in completion?()
        })
        
        return alert
    }
    
    public class func doubleBtnAlertWithTitle(title: String, message: String, okActionTitle: String, otherBtnTitle: String, completion: (() -> Void)?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: otherBtnTitle, style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: okActionTitle, style: .cancel) {
            _ in completion?()
        })
        
        return alert
    }
    
}
