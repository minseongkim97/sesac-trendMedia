//
//  APIManager.swift
//  sesac-trendMedia
//
//  Created by MIN SEONG KIM on 2022/08/05.
//

import Foundation

import Alamofire
import SwiftyJSON

class APIManager {
    static let shared = APIManager()
    
    var isPaginating = false
    
    private init() { }
    
    typealias tmdbCompletion = ((Int, [TV]) -> Void)
    typealias creditsCompletion = ((Result<[String], Error>) -> Void)
    
    func requestTMDB(pagination: Bool = false, page: Int, completion: @escaping tmdbCompletion) {
        let tvURL = EndPoint.baseURL + EndPoint.trendingURL + "page=\(page)" + "&" + "api_key=\(APIKey.tmdbKey)"
        
        if pagination {
            isPaginating = true
        }
        
        AF.request(tvURL, method: .get).validate().responseData() { response in
//            var movies = [Movie]()
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                json["results"].arrayValue.forEach {
//                    var movie = Movie.defaultMovie()
//                    movie.id = $0["id"].intValue
//                    movie.title = $0["title"].stringValue
//                    movie.genres = $0["genre_ids"].arrayValue.map { "#\(Constant.genre[$0.intValue] ?? "엥")" }
//                    movie.thumbnail = $0["poster_path"].string
//                    movie.average = $0["vote_average"].doubleValue
//                    movie.releaseDate = $0["release_date"].stringValue
//
//                    self?.requestMovieCredits(id: $0["id"].intValue, completion: { result in
//                        switch result {
//                        case .success(let actors):
//                            movie.actor = actors
//                            movies.append(movie)
//                        case .failure(let error):
//                            print(error)
//                        }
//                    })
//                }
                let totalPages = json["total_pages"].intValue
                let tvs = json["results"].arrayValue.map {
                    return TV(id: $0["id"].intValue,
                                 title: $0["name"].stringValue,
                                 actor: [],
                                 genres: $0["genre_ids"].arrayValue.map { "#\(Constant.genre[$0.intValue] ?? "TV")" },
                                 thumbnail: $0["poster_path"].string,
                                 average: $0["vote_average"].doubleValue,
                                 releaseDate: $0["first_air_date"].stringValue)
                }
                
                completion(totalPages, tvs)
                if pagination {
                    self.isPaginating = false
                }
          
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestTVCredits(id: Int, completion: @escaping creditsCompletion) {
        let creditsURL = EndPoint.baseURL + EndPoint.creditsURL(of: id) + "api_key=\(APIKey.tmdbKey)"
        AF.request(creditsURL, method: .get).validate().responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let actors = json["cast"].arrayValue.map { $0["name"].stringValue }
                completion(.success(actors))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
}
