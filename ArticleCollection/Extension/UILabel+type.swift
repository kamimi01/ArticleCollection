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
        case qiita = "qiita"
        case note = "note"
        case hatena = "hatena"
    }
    
    func customizeLabel(_ type: LabelCustomType, _ serviceName: String) {
        var articleMetaInfo = ArticleMetaInfo.init(siteNameType: .qiita)
        switch type {
        case .tag:
            switch serviceName {
            case ServiceType.qiita.rawValue:
                self.layer.backgroundColor = UIColor.qiitaColor.cgColor
                articleMetaInfo = ArticleMetaInfo.init(siteNameType: .qiita)
            case ServiceType.note.rawValue:
                self.layer.backgroundColor = UIColor.noteColor.cgColor
                articleMetaInfo = ArticleMetaInfo.init(siteNameType: .note)
            case ServiceType.hatena.rawValue:
                articleMetaInfo = ArticleMetaInfo.init(siteNameType: .hatenaBlog)
                self.layer.backgroundColor = UIColor.hatenaColor.cgColor
            default:
                self.layer.backgroundColor = UIColor.boldGray.cgColor
            }
            self.text = articleMetaInfo.siteName
            self.textColor = UIColor.white
            self.clipsToBounds = true
            self.numberOfLines = 1
        }
    }
}
