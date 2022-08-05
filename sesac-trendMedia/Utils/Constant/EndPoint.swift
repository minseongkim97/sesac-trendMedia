//
//  EndPoint.swift
//  sesac-trendMedia
//
//  Created by MIN SEONG KIM on 2022/08/04.
//

import Foundation

struct EndPoint {
    static let baseURL = "https://api.themoviedb.org/3"
    static let imagePath = "https://image.tmdb.org/t/p/w500"
    static let trendingURL = "/trending/tv/week?"
    static let genreURL = "https://api.themoviedb.org/3/genre/tv/list"
    
    static func creditsURL(of id: Int) -> String {
        return "/tv/\(id)/credits?"
    }
}
