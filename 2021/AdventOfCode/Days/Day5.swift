//
//  Day5.swift
//  AdventOfCode
//

import Foundation
import RegularExpressionDecoder

final class Day5: Day {
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
    
    struct Line: Decodable {
        enum CodingKeys: String, CodingKey {
            case start
            case end
        }

        let start: Point
        let end: Point
        
        var isHorizontal: Bool { start.y == end.y }
        var isVertical: Bool { start.x == end.x }
        var maxX: Int { max(start.x, end.x) }
        var maxY: Int { max(start.y, end.y) }
        
        var normalized: Line {
            if isVertical {
                return start.y < end.y ? self : reversed
            } else {
                return start.x < end.x ? self : reversed
            }
        }
        
        var reversed: Line {
            Line(start: end, end: start)
        }
        
        var points: [Point] {
            if isVertical {
                return (start.y...end.y).map { Point(x: start.x, y: $0) }
            } else if isHorizontal {
                return (start.x...end.x).map { Point(x: $0, y: start.y) }
            } else {
                let yStride = (end.y - start.y).signum()
                return (start.x...end.x).map { x in
                    Point(x: x, y: start.y + (x - start.x) * yStride)
                }
            }
        }
        
        init(start: Point, end: Point) {
            self.start = start
            self.end = end
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let start: [Int] = try container.decode(String.self, forKey: .start)
                .components(separatedBy: ",")
                .compactMap(Int.init)
            let end = try container.decode(String.self, forKey: .end)
                .components(separatedBy: ",")
                .compactMap(Int.init)

            self.start = try Day5.Point(start)
            self.end = try Day5.Point(end)
        }
    }
    
    let pattern: RegularExpressionPattern<Line, Line.CodingKeys> = #"""
    \b
    (?<\#(.start)>\d+,\d+)
    \s->\s
    (?<\#(.end)>\d+,\d+)
    \b
    """#
    
    func part1(_ input: String) throws -> CustomStringConvertible {
        let decoder = try RegularExpressionDecoder<Line>(pattern: pattern, options: .allowCommentsAndWhitespace)
        let lines = try decoder.decode([Line].self, from: input)
            .filter { $0.isVertical || $0.isHorizontal }
        
        guard
            let rows = lines.map(\.maxY).max()?.advanced(by: 1),
            let columns = lines.map(\.maxX).max()?.advanced(by: 1) else {
                return "Error"
            }
        
        var oceanFloor = Matrix(repeating: 0, rows: rows, columns: columns)
        lines.forEach { oceanFloor.apply(line: $0) }
        
        return oceanFloor.count { $0 > 1 }
    }

    func part2(_ input: String) throws -> CustomStringConvertible {
        let decoder = try RegularExpressionDecoder<Line>(pattern: pattern, options: .allowCommentsAndWhitespace)
        let lines = try decoder.decode([Line].self, from: input)
        
        guard
            let rows = lines.map(\.maxY).max()?.advanced(by: 1),
            let columns = lines.map(\.maxX).max()?.advanced(by: 1) else {
                return "Error"
            }
        
        var oceanFloor = Matrix(repeating: 0, rows: rows, columns: columns)
        lines.forEach { oceanFloor.apply(line: $0) }
        
        return oceanFloor.count { $0 > 1 }
    }
}

extension Matrix where Element == Int {
    mutating func apply(line: Day5.Line) {
        line.normalized.points.forEach {
            self[$0.y, $0.x] += 1
        }
    }
}
