//
//  Day2.swift
//  AdventOfCode
//

import Foundation
import RegularExpressionDecoder

final class Day2: Day {
    enum Move: Decodable {
        enum CodingKeys: String, CodingKey {
            case direction
            case distance
        }
        
        case forward(Int)
        case up(Int)
        case down(Int)
        
        var isVertical: Bool {
            if case .forward = self {
                return false
            }
            return true
        }
        
        var value: Int {
            switch self {
            case let .forward(distance), let .down(distance):
                return distance
            case let .up(distance):
                return -distance
            }
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            let direction = try container.decode(String.self, forKey: .direction)
            let distance = try container.decode(Int.self, forKey: .distance)
            
            switch direction {
            case "forward":
                self = .forward(distance)
            case "down":
                self = .down(distance)
            case "up":
                self = .up(distance)
            default:
                throw DecodingError.dataCorruptedError(forKey: .direction, in: container, debugDescription: "Unexpected direction \(direction)")
            }
        }
    }
    
    struct Movement {
        static let zero = Movement(horizontal: 0, vertical: 0)
        
        let horizontal: Int
        let vertical: Int
        
        func movedVertically(by amount: Int) -> Movement {
            return Movement(horizontal: horizontal, vertical: vertical + amount)
        }
        
        func movedHorizontally(by amount: Int) -> Movement {
            return Movement(horizontal: horizontal + amount, vertical: vertical)
        }
    }
    
    let pattern: RegularExpressionPattern<Move, Move.CodingKeys> = #"""
        \b
        (?<\#(.direction)>[a-z]+)\s
        (?<\#(.distance)>\d+)
        \b
        """#
    
    func part1(_ input: String) throws -> CustomStringConvertible {
        let moves: [Move]
        let decoder = try RegularExpressionDecoder<Move>(pattern: pattern, options: .allowCommentsAndWhitespace)
        moves = try decoder.decode([Move].self, from: input)
        
        let distance: Movement = moves.reduce(.zero) { distance, move in
            if move.isVertical {
                return distance.movedVertically(by: move.value)
            } else {
                return distance.movedHorizontally(by: move.value)
            }
        }

        return distance.horizontal * distance.vertical
    }

    func part2(_ input: String) throws -> CustomStringConvertible {
        let moves: [Move]
        let decoder = try RegularExpressionDecoder<Move>(pattern: pattern, options: .allowCommentsAndWhitespace)
        moves = try decoder.decode([Move].self, from: input)
        
        var aim: Int = 0
        var position: Int = 0
        var depth: Int = 0
        moves.forEach { move in
            if move.isVertical {
                aim += move.value
            } else {
                position += move.value
                depth += aim * move.value
            }
        }
        
        return position * depth
    }
}
