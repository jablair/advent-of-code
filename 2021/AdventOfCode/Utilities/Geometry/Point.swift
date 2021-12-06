//
//  Point.swift
//  AdventOfCode
//
//  Created by Eric Blair on 12/5/21.
//

import Foundation

struct Point {
    enum Error: Swift.Error {
        case tooManyValues(Int)
        case insufficientValues
    }
    let x: Int
    let y: Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    init(_ array: [Int]) throws {
        guard array.count == 2 else {
            if array.count < 2 {
                throw Error.insufficientValues
            } else {
                throw Error.tooManyValues(array.count)
            }
        }
        
        self.x = array[0]
        self.y = array[1]
    }
}
