//
//  CatologyImageMetaModel.swift
//  Catology
//
//  Created by Emmanuel Albania on 10/9/24.
//

import Foundation

public struct CatologyContentModel: Codable {
    public let id: String
    public let url: String
    public private(set) var fact: String?
    
    public init(id: String, url: String, fact: String? = nil) {
        self.id = id
        self.url = url
        self.fact = fact
    }
    
    @discardableResult
    public func set(fact: String) -> CatologyContentModel {
        var model = self
        model.fact = fact
        return model
    }
}
