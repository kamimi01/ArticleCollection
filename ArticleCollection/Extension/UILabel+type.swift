//
//  UILabel+type.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2021/04/29.
//

import UIKit

class TagLabel: UILabel {
    var tagPadding: CGFloat = 7
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: tagPadding, left: tagPadding, bottom: tagPadding, right: tagPadding)
        super.drawText(in: rect.inset(by: insets))
    }
}

extension UILabel {
    enum LabelCustomType {
        case tag
    }
    
    enum ServiceType: String {
        case qiita = "Qiita"
        case note = "note"
        case hatena = "hatena"
    }
    
    func customizeLabel(_ type: LabelCustomType, _ serviceName: String) {
        switch type {
        case .tag:
            switch serviceName {
            case ServiceType.qiita.rawValue:
                self.layer.backgroundColor = UIColor.qiitaColor.cgColor
            case ServiceType.note.rawValue:
                self.layer.backgroundColor = UIColor.noteColor.cgColor
            case ServiceType.hatena.rawValue:
                self.layer.backgroundColor = UIColor.hatenaColor.cgColor
            default:
                self.layer.backgroundColor = UIColor.boldGray.cgColor
            }
            self.textColor = UIColor.white
            self.clipsToBounds = true
            self.numberOfLines = 1
        }
    }
}
