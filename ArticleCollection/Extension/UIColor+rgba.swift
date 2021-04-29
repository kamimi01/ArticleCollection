//
//  UIColor+rgba.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2020/09/27.
//

import Foundation
import UIKit

extension UIColor{
    // オレンジ
    static var onion: UIColor {
        return UIColor(red: 253/255, green: 155/255, blue: 87/255, alpha: 1)
    }
    
    // ブラウン
    static var driftWood: UIColor {
        return UIColor(red: 128/255, green: 90/255, blue: 59/255, alpha: 1)
    }
    
    // ライトブラウン
    static var lightDriftWood: UIColor {
        return UIColor(red: 128/255, green: 90/255, blue: 59/255, alpha: 0.33)
    }
    
    // ライトグレー
    static var gray: UIColor {
        return UIColor(red: 129/255, green: 129/255, blue: 129/255, alpha: 1)
    }
    
    // ボールドグレー
    static var boldGray: UIColor {
        return UIColor(red: 82/255, green: 82/255, blue: 82/255, alpha: 1)
    }
    
    // マッシュルームブラウン
    static var mushRoom: UIColor {
        return UIColor(red: 234/255, green: 226/255, blue: 214/255, alpha: 1)
    }
    
    // Qiitaのサービスカラー
    static var qiitaColor: UIColor {
        return UIColor(red: 113/255, green: 189/255, blue: 56/255, alpha: 1)
    }
    
    // noteのサービスカラー
    static var noteColor: UIColor {
        return UIColor(red: 90/255, green: 179/255, blue: 152/255, alpha: 1)
    }

    // Hatena Blogのサービスカラー
    static var hatenaColor: UIColor {
        return UIColor(red: 36/255, green: 37/255, blue: 39/255, alpha: 1)
    }
}
