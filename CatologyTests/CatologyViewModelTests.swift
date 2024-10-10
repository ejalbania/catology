//
//  CatologyViewModelTests.swift
//  CatologyTests
//
//  Created by Emmanuel Albania on 10/9/24.
//

import XCTest
@testable import Catology

class CatologyViewModelTests: XCTestCase {
    let mockService: any CatologyFactsServiceProviderType = CatologyFactsServiceMock()
    lazy var sut: any CatologyViewModelType = CatologyViewModel(service: mockService)
    
    func testFetchRandomFacts() {
        let mockedModel = CatologyContentMock.data
        XCTAssertEqual(sut.contentModel.count, 0)
        XCTAssertEqual(sut.presentedIndex, 0)
        XCTAssertNil(sut.nextFact)
        XCTAssertNil(sut.nextImageURL)
        
        for (index, data) in mockedModel.enumerated() {
            sut.performScreenClickAction()
            
            XCTAssertEqual(sut.nextFact, data.fact)
            XCTAssertEqual(sut.nextImageURL, data.url)
            XCTAssertEqual(sut.presentedIndex, index)
        }
        
        XCTAssertEqual(sut.contentModel.count, 20)
        
    }
    
}
