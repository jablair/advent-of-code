//
//  Day4.swift
//  AdventOfCode
//

import Foundation
import RegularExpressionDecoder

final class Day4: Day {
    struct Assignments: Decodable {
        enum CodingKeys: String, CodingKey {
            case leftMin
            case leftMax
            case rightMin
            case rightMax
        }
        
        let left: Set<Int>
        let right: Set<Int>
        
        var isFullyOverlapping: Bool {
            left.isSubset(of: right) || right.isSubset(of: left)
        }
        
        var isOverlapping: Bool {
            !left.intersection(right).isEmpty
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let leftMin = try container.decode(Int.self, forKey: .leftMin)
            let leftMax = try container.decode(Int.self, forKey: .leftMax)
            let rightMin = try container.decode(Int.self, forKey: .rightMin)
            let rightMax = try container.decode(Int.self, forKey: .rightMax)
            
            left = Set(leftMin...leftMax)
            right = Set(rightMin...rightMax)
        }
    }
    
    var assignments: [Assignments]!

    func setup(_ input: String) throws {
        let pattern: RegularExpressionPattern<Assignments, Assignments.CodingKeys> = #"""
            \b
            (?<\#(.leftMin)>\d+)-(?<\#(.leftMax)>\d+),
            (?<\#(.rightMin)>\d+)-(?<\#(.rightMax)>\d+)
            \b
        """#

        let decoder = try RegularExpressionDecoder<Assignments>(pattern: pattern, options: .allowCommentsAndWhitespace)
        assignments = try decoder.decode([Assignments].self, from: input)
    }
    
    func part1(_ input: String) async throws -> Int {
        return assignments.filter(\.isFullyOverlapping).count
    }

    func part2(_ input: String) async throws -> Int {
        return assignments.filter(\.isOverlapping).count
    }
}
