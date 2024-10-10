//
//  CatologyFactsService.swift
//  Catology
//
//  Created by Emmanuel Albania on 10/8/24.
//

import Moya
import Combine

public protocol CatologyFactsServiceProviderType {
    func fetchRandomFacts() -> AnyPublisher<[String], CatologyFactsRequestError>
    func fetchRandomImage() -> AnyPublisher<[CatologyContentModel], CatologyFactsRequestError>
}

class CatologyFactsProviderService {
    private let provider = MoyaProvider<CatologyMeowFactsRequest>()
    private var cancellable = Set<AnyCancellable>()
}

extension CatologyFactsProviderService: CatologyFactsServiceProviderType {
    
    func fetchRandomFacts() -> AnyPublisher<[String], CatologyFactsRequestError> {
        Future<[String], CatologyFactsRequestError> { promise in
            self.provider.request(.fetchRandomFacts) { result in
                switch result {
                    case let .failure(error):
                        promise(.failure(.requestError(error: error)))
                    case let .success(response):
                        guard let json = try? JSONDecoder().decode([String: [String]].self, from: response.data),
                              let facts = json["data"] else {
                            return promise(.failure(.parsingError(statusCode: response.statusCode, method: #function)))
                        }
                        
                        promise(.success(facts))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func fetchRandomImage() -> AnyPublisher<[CatologyContentModel], CatologyFactsRequestError> {
        Future<[CatologyContentModel], CatologyFactsRequestError> { promise in
            self.provider.request(.fetchRandomImageURLs) { result in
                switch result {
                    case let .failure(error):
                        promise(.failure(.requestError(error: error)))
                    case let .success(response):
                        guard let models = try? JSONDecoder().decode([CatologyContentModel].self, from: response.data) else {
                            return promise(.failure(.parsingError(statusCode: response.statusCode, method: #function)))
                        }
                        
                        promise(.success(models))
                }
            }
        }.eraseToAnyPublisher()
    }
}
