//
//  Operators.swift
//  Catology
//
//  Created by Emmanuel Albania on 10/8/24.
//

import Foundation

postfix operator ++

public postfix func ++<T: Numeric>(_ value: inout T) {
  value = value + 1
}
