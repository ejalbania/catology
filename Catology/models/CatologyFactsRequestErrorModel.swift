//
//  CatologyFactsRequestErrorModel.swift
//  Catology
//
//  Created by Emmanuel Albania on 10/8/24.
//

import Moya

public enum CatologyFactsRequestError: Error {
    case parsingError(statusCode: Int, method: String)
    case requestError(error: MoyaError)
    
    var model: Model {
        switch self {
            case let .parsingError(code, method):
                Model(code: code.toString, message: "Data parsing error in \(method)")
            case let .requestError(error):
                Model(code: error.errorCode.toString, message: error.failureReason ?? error.localizedDescription)
        }
    }
}

public extension CatologyFactsRequestError {
    struct Model: Codable {
        let code: String
        let message: String
    }
}
