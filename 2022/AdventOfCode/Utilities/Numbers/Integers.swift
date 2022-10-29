//
//  Integers.swift
//  AdventOfCode
//
//  Created by Eric Blair on 12/8/21.
//

import Foundation

extension FixedWidthInteger {
    var digits: [Self] {
        var reversedDigits: [Self] = []
        var current = self
        while current != 0 {
            let remainder = current % 10
            current = current / 10
            reversedDigits.append(remainder)
        }
        
        return Array(reversedDigits.reversed())
    }
}

extension Int {
    
    var isEven: Bool { isMultiple(of: 2)}
    var isOdd: Bool { !isEven }

    init<C: Collection>(digits: C) where C.Element == Int {
        self = digits.reversed().enumerated().reduce(0) { result, value in
            let (power, digit) = value
            return result + abs(digit) * Int(pow(10, Double(power)))
        }
    }
    
    init<C: Collection>(bits: C) where C.Element == Bool {
        self = bits.reduce(0) { result, on in
            result * 2 + (on ? 1 : 0)
        }
    }

}
