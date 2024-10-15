//
//  CatologyMeowFactsRequest.swift
//  Catology
//
//  Created by Emmanuel Albania on 10/8/24.
//

import Moya

enum CatologyMeowFactsRequest {
  case fetchRandomFacts
  case fetchRandomImageURLs
}

extension CatologyMeowFactsRequest: TargetType {
  var baseURL: URL {
    var urlString: String {
      switch self {
        case .fetchRandomFacts: "https://meowfacts.herokuapp.com/?count=10"
        case .fetchRandomImageURLs: "https://api.thecatapi.com/v1/images/search?limit=10"
      }
    }
    return URL(string: urlString)!
  }
  
  var path: String { "" }
  
  var method: Moya.Method { .get }
  
  var task: Moya.Task { .requestPlain }
  
  var headers: [String : String]? { [:] }
}
