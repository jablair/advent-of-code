//
//  Day2.swift
//  AdventOfCode
//

import Foundation

final class Day2: Day {
    enum Move {
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

        init?(direction: String, distance: Int) {
            switch direction {
            case "forward":
                self = .forward(distance)
            case "down":
                self = .down(distance)
            case "up":
                self = .up(distance)
            default:
                return nil
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
    
    func part1(_ input: String) -> CustomStringConvertible {
        let moves = input
            .split(separator: "\n")
            .compactMap { line -> Move? in
                let ins = line.split(separator: " ")
                guard let distance = Int(ins[1]) else {
                    return nil
                }
                
                return Move(direction: String(ins[0]), distance: distance)
            }
        
        let distance: Movement = moves.reduce(.zero) { distance, move in
            if move.isVertical {
                return distance.movedVertically(by: move.value)
            } else {
                return distance.movedHorizontally(by: move.value)
            }
        }

        return distance.horizontal * distance.vertical
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let moves = input
            .split(separator: "\n")
            .compactMap { line -> Move? in
                let ins = line.split(separator: " ")
                guard let distance = Int(ins[1]) else {
                    return nil
                }
                
                return Move(direction: String(ins[0]), distance: distance)
            }

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
