//
//  TMDB.swift
//  sesac-trendMedia
//
//  Created by MIN SEONG KIM on 2022/08/04.
//

import Foundation

struct TV {
    var id: Int
    var title: String
    var actor: [String]
    var genres: [String]
    var thumbnail: String?
    var average: Double
    var releaseDate: String
    
    static func defaultTV() -> TV {
        return TV(id: 0,
                     title: "TV",
                     actor: [],
                     genres: [],
                     thumbnail: nil,
                     average: 0.0,
                     releaseDate: "00/00/0000")
    }
}
