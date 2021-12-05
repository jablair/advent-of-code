//
//  Day5.swift
//  AdventOfCode
//

import Foundation
import RegularExpressionDecoder

final class Day5: Day {
    typealias Point = (x: Int, y: Int)
    
    struct Line: Decodable {
        enum CodingKeys: String, CodingKey {
            case xStart
            case yStart
            case xEnd
            case yEnd
        }

        let xStart: Int
        let yStart: Int
        let xEnd: Int
        let yEnd: Int
        
        var isHorizontal: Bool { yStart == yEnd }
        var isVertical: Bool { xStart == xEnd }
        var maxX: Int { max(xStart, xEnd) }
        var maxY: Int { max(yStart, yEnd) }
        
        var normalized: Line {
            if isVertical {
                return yStart < yEnd ? self : reversed
            } else {
                return xStart < xEnd ? self : reversed
            }
        }
        
        var reversed: Line {
            Line(xStart: xEnd, yStart: yEnd, xEnd: xStart, yEnd: yStart)
        }
        
        var points: [Point] {
            if isVertical {
                return (yStart...yEnd).map { (xStart, $0) }
            } else if isHorizontal {
                return (xStart...xEnd).map { ($0, yStart) }
            } else {
                let yStride = yStart < yEnd ? 1 : -1
                return (xStart...xEnd).map { x in
                    (x, yStart + (x - xStart) * yStride)
                }
            }
        }
    }
    
    let pattern: RegularExpressionPattern<Line, Line.CodingKeys> = #"""
    \b
    (?<\#(.xStart)>\d+),
    (?<\#(.yStart)>\d+)
    \s->\s
    (?<\#(.xEnd)>\d+),
    (?<\#(.yEnd)>\d+)
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
        
        let oceanFloor = Matrix(repeating: 0, rows: rows, columns: columns)
        lines.forEach(oceanFloor.apply)
        
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
        
        let oceanFloor = Matrix(repeating: 0, rows: rows, columns: columns)
        lines.forEach(oceanFloor.apply)
        
        return oceanFloor.count { $0 > 1 }
    }
}

extension Matrix where Element == Int {
    func apply(line: Day5.Line) {
        line.normalized.points.forEach {
            self[$0.y, $0.x] += 1
        }
    }
}
