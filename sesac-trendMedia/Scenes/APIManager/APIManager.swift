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
    
    typealias completion = ((String) -> Void)
    typealias tmdbCompletion = ((Int, [TV]) -> Void)
    typealias creditsCompletion = (([Cast], [Crew]) -> Void)
    
    func requestTMDB(pagination: Bool = false, page: Int, completion: @escaping tmdbCompletion) {
        let tvURL = EndPoint.baseURL + EndPoint.trendingURL + "page=\(page)" + "&" + "api_key=\(APIKey.tmdbKey)"

        if pagination {
            isPaginating = true
        }

        AF.request(tvURL, method: .get).validate().responseData() { [weak self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)

                let totalPages = json["total_pages"].intValue

                let tvList = json["results"].arrayValue.map {
                    return TV(id: $0["id"].intValue,
                              title: $0["name"].stringValue,
                              actor: [],
                              genres: $0["genre_ids"].arrayValue.map { "#\(Constant.genre[$0.intValue] ?? "TV")" },
                              thumbnail: $0["poster_path"].string,
                              backdropPath: $0["backdrop_path"].string,
                              average: $0["vote_average"].doubleValue,
                              releaseDate: $0["first_air_date"].stringValue,
                              overview: $0["overview"].stringValue)
                }


                completion(totalPages, tvList)

                if pagination {
                    self?.isPaginating = false
                }

            case .failure(let error):
                print(error)
            }
        }
    }
 
    

//    func requestTVCredits(id: Int, completion: @escaping creditsCompletion) {
//        let creditsURL = EndPoint.baseURL + EndPoint.creditsURL(of: id) + "api_key=\(APIKey.tmdbKey)"
//        AF.request(creditsURL, method: .get).validate().responseData(queue: .global()) { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                let actors = json["cast"].arrayValue.map { $0["name"].stringValue }
//                completion(.success(actors))
//            case .failure(let error):
//                print(error)
//                completion(.failure(error))
//            }
//        }
//    }
    
    
    func requestTVCredits(id: Int, completion: @escaping creditsCompletion) {
        let creditsURL = EndPoint.baseURL + EndPoint.creditsURL(of: id) + "api_key=\(APIKey.tmdbKey)"
        
        AF.request(creditsURL, method: .get).validate().responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let casts = json["cast"].arrayValue.map {
                    return Cast(name: $0["name"].stringValue,
                                  department: $0["department"].stringValue,
                                  profilePath: $0["profile_path"].string,
                                  character: $0["character"].stringValue)
                }
                let crews = json["crew"].arrayValue.map {
                    return Crew(name: $0["name"].stringValue,
                                profilePath: $0["profile_path"].string,
                                department: $0["department"].stringValue,
                                job: $0["job"].stringValue)
                }
                completion(casts, crews)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestVideoKey(id: Int, completion: @escaping completion) {
        let videoURL = EndPoint.baseURL + EndPoint.videosURL(of: id) + "api_key=\(APIKey.tmdbKey)"
        AF.request(videoURL, method: .get).validate().responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let key = json["results"][0]["key"].stringValue
            
                completion(key)
            case .failure(let error):
                print(error)
            }
        }
    }
}
