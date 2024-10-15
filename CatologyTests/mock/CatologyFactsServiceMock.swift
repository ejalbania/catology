//
//  CatologyFactsServiceMock.swift
//  CatologyTests
//
//  Created by Emmanuel Albania on 10/8/24.
//

import Catology
import Combine

class CatologyFactsServiceMock {
    private var factsRequestCounter: Int = 0
    private var imageURLRequestCounter: Int = 0
    private let contentModel = CatologyContentMock.data
    
    private func mockedFactReturn() -> [String] {
        let startingIndex = factsRequestCounter*10
        guard startingIndex < contentModel.count else { return [] }
        
        let mock = contentModel[startingIndex...startingIndex+9].compactMap(\.fact)
        factsRequestCounter++
        return mock
    }
    
    private func mockedImageURLReturn() -> [CatologyContentModel] {
        let startingIndex = imageURLRequestCounter*10
        guard startingIndex < contentModel.count else { return [] }
        
        let mock = contentModel[startingIndex...startingIndex+9]
        imageURLRequestCounter++
        return mock.map { CatologyContentModel(id: $0.id, url: $0.url) }
    }
}


extension CatologyFactsServiceMock: CatologyFactsServiceProviderType {
    func fetchRandomFacts() -> AnyPublisher<[String], CatologyFactsRequestError> {
        Future<[String], Catology.CatologyFactsRequestError> { [weak self] promise in
            guard let `self` else { return }
            promise(.success(self.mockedFactReturn()))
        }.eraseToAnyPublisher()
    }
    
    func fetchRandomImage() -> AnyPublisher<[CatologyContentModel], CatologyFactsRequestError> {
        Future<[CatologyContentModel], CatologyFactsRequestError> { [weak self] promise in
            guard let `self` else { return }
            promise(.success(self.mockedImageURLReturn()))
        }.eraseToAnyPublisher()
    }
}
