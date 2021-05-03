//
//  DateFormat.swift
//  ArticleCollection
//
//  Created by Mika Urakawa on 2021/05/04.
//

import Foundation

class DateFormat {
    enum Template: String {
        case full = "yyyy/MM/dd"
    }
    
    public static func formatDateToString(_ formatType: Template, _ formattedString: String) -> String {
        let dateFormatter = DateFormatter()
        // フォーマット設定
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXX"
        
        // ロケール設定（端末の暦設定に引きづられないようにする）
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        // タイムゾーン設定（端末設定によらず固定にしたい場合）
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        
        let date = dateFormatter.date(from: formattedString) ?? Date()
        
        dateFormatter.dateFormat = formatType.rawValue
        
        // 変換
        let str = dateFormatter.string(from: date)
        
        return str
    }
}
