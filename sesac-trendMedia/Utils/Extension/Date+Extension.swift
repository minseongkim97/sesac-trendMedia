//
//  Date+Extension.swift
//  sesac-trendMedia
//
//  Created by MIN SEONG KIM on 2022/08/05.
//

import Foundation

extension Date {
    //MARK: - releaseDate 표시
    var text: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: self)
    }
}
