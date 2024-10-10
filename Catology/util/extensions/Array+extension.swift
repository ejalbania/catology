//
//  Array+extension.swift
//  Catology
//
//  Created by Emmanuel Albania on 10/8/24.
//

public extension Array {
  subscript(safe index: Int) -> Element? {
    guard index < self.count else { return nil }
    return self[index]
  }
}
