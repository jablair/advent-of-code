//
//  Day17.swift
//  AdventOfCode
//

import Foundation
import Algorithms
import RegularExpressionDecoder


final class Day17: Day {

    struct Target: Decodable {
        
        enum CodingKeys: String, CodingKey {
            case minX
            case maxX
            case minY
            case maxY
        }
        
        let minX: Int
        let maxX: Int
        let minY: Int
        let maxY: Int
        
        var xRange: ClosedRange<Int> { minX...maxX }
        var yRange: ClosedRange<Int> { minY...maxY }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.minX = try container.decode(Int.self, forKey: .minX)
            self.maxX = try container.decode(Int.self, forKey: .maxX)
            self.minY = try container.decode(Int.self, forKey: .minY)
            self.maxY = try container.decode(Int.self, forKey: .maxY)
        }

        func contains(point: Point) -> Bool {
            xRange.contains(point.x) && yRange.contains(point.y)
        }
    }

    let targetPattern: RegularExpressionPattern<Target, Target.CodingKeys> = #"""
    target\sarea:\s
    x=(?<\#(.minX)>-?\d+)
    \.\.
    (?<\#(.maxX)>-?\d+),\s
    y=(?<\#(.minY)>-?\d+)
    \.\.
    (?<\#(.maxY)>-?\d+)
    """#
    
    func testProbes(to target: Target) -> (hits: [(vX: Int, vY: Int)], maxY: Int) {
        var hits: [(Int, Int)] = []
        var maxY = 0
        for initialVX in 1...target.maxX {
            for initialVY in target.minY...abs(target.minY) {
                var vX = initialVX
                var vY = initialVY
                var point = Point.zero
                var localMaxY = 0
                while !target.contains(point: point) {
                    localMaxY = max(localMaxY, point.y)
                    
                    point.x += vX
                    point.y += vY
                    
                    if point.y < target.minY {
                        break
                    }

                    vX -= vX.signum()
                    vY -= 1
                }
                
                if target.contains(point: point) {
                    hits.append((initialVX, initialVY))
                    maxY = max(maxY, localMaxY)
                }
                
            }
        }
        
        return (hits, maxY)
    }
    
    var maxY: Int = 0
    var hitCount: Int = 0
    
    func setup(_ input: String) throws {
        let decoder = try RegularExpressionDecoder<Target>(pattern: targetPattern, options: .allowCommentsAndWhitespace)
        let target = try decoder.decode(Target.self, from: input)
        
        let results = testProbes(to: target)
        maxY = results.maxY
        hitCount = results.hits.count
    }
    
    func part1(_ input: String) throws -> CustomStringConvertible {
        return maxY
    }
    
    func part2(_ input: String) throws -> CustomStringConvertible {
        return hitCount
    }
}
