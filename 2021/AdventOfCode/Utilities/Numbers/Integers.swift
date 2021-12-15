//
//  Integers.swift
//  AdventOfCode
//
//  Created by Eric Blair on 12/8/21.
//

import Foundation

extension Int {
    
    var isEven: Bool { isMultiple(of: 2)}
    var isOdd: Bool { !isEven }

    init<C: Collection>(digits: C) where C.Element == Int {
        self = digits.reversed().enumerated().reduce(0) { result, value in
            let (power, digit) = value
            return result + abs(digit) * Int(pow(10, Double(power)))
        }
    }

}
