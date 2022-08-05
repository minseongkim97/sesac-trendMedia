//
//  String+Extension.swift
//  sesac-trendMedia
//
//  Created by MIN SEONG KIM on 2022/08/05.
//

import Foundation

extension String {
    //MARK: - releaseDate 표시
    var date: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self) {
            return date
        }
        return Date()
    }
}
