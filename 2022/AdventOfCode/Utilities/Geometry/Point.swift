//
//  Point.swift
//  AdventOfCode
//
//  Created by Eric Blair on 12/5/21.
//

import Foundation

//infix operator +

struct Point: Hashable, Equatable {
    enum Error: Swift.Error {
        case tooManyValues(Int)
        case insufficientValues
    }
    
    static let zero = Point(x: 0, y: 0)
    
    var x: Int
    var y: Int
    
    var row: Int { y }
    var col: Int { x }
    
    init(x: Int = 0, y: Int = 0) {
        self.x = x
        self.y = y
    }
    
    init(row: Int, col: Int) {
        self.init(x: col, y: row)
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
    
    func isOrthoginal(to point: Point) -> Bool {
        return x == point.x || y == point.y
    }
    
    func isAdjascent(to point: Point, includeDiagonals: Bool = true) -> Bool {
        if self.x == point.x && abs(self.y - point.y) <= 1 {
            return true
        } else if self.y == point.y && abs(self.x - point.x) <= 1 {
            return true
        } else if abs(self.x - point.x) == 1 && abs(self.y - point.y) == 1 {
            return true
        }
        
        return false
    }
    
    func isVerticallyAligned(to point: Point) -> Bool {
        return y == point.y
    }
    
    func isHorizontallyAligned(to point: Point) -> Bool {
        return x == point.x
    }
    
    func neighbors() -> [Point] {
        return [
            Point(x: x-1, y: y),
            Point(x: x+1, y: y),
            Point(x: x, y: y-1),
            Point(x: x, y: y+1)
        ]
    }
    
    static func +(lhs: Point, rhs: Point) -> Point {
        return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}

extension Point: CustomStringConvertible {
    var description: String { "[\(x), \(y)]" }
}
