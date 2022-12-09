//
//  Day9.swift
//  AdventOfCode
//

import Foundation
import Parsing

final class Day9: Day {
    enum Direction: String, CaseIterable {
        case right = "R"
        case left = "L"
        case up = "U"
        case down = "D"
    }
    
    struct Move {
        let direction: Direction
        let distance: Int
    }
    
    var moves: [Move]!
    
    func setup(_ input: String) throws {
        let moveParser = Parse {
            Direction.parser()
            " "
            Int.parser()
        }.map( { Move(direction: $0, distance: $1) })
        
        moves = try input.lines.map {
            try moveParser.parse($0)
        }
    }
    
    func part1(_ input: String) async throws -> Int {
        var knots = [Point.zero, Point.zero]
        var visited: Set<Point> = [Point.zero]
        
        for move in moves {
            process(move: move, knots: &knots).forEach { visited.insert($0)}
        }
        
        
        return visited.count
    }

    func part2(_ input: String) async throws -> Int {
        var knots = Array(repeating: Point.zero, count: 10)
        var visited: Set<Point> = [.zero]
        
        for move in moves {
            process(move: move, knots: &knots).forEach { visited.insert($0) }
        }
        
        return visited.count
    }
    
    private func update(knot: inout Point, to previous: Point) {
        guard !knot.isNeighbor(of: previous) else { return }
        
        if abs(previous.x - knot.x) > 1 {
            if previous.x > knot.x {
                knot.x += 1
            } else {
                knot.x -= 1
            }
            
            if previous.y < knot.y {
                knot.y -= 1
            } else if previous.y > knot.y {
                knot.y += 1
            }
        } else if abs(previous.y - knot.y) > 1 {
            if previous.y > knot.y {
                knot.y += 1
            } else {
                knot.y -= 1
            }
            
            if previous.x < knot.x {
                knot.x -= 1
            } else if previous.x > knot.x {
                knot.x += 1
            }
        }
        
    }
    
    func process(move: Move, knots: inout [Point]) -> Set<Point> {
        var visited: Set<Point> = []
        
        let tailIndex = knots.endIndex - 1

        (0..<move.distance).forEach { _ in
            switch move.direction {
            case .left:
                knots[0].x -= 1
            case .right:
                knots[0].x += 1
            case .up:
                knots[0].y += 1
            case .down:
                knots[0].y -= 1
            }
            
            for(previousIdx, currentIdx) in knots.indices.adjacentPairs() {
                let knot = knots[currentIdx]
                update(knot: &knots[currentIdx], to: knots[previousIdx])
                
                if knot == knots[currentIdx] {
                    break
                }
                if currentIdx == tailIndex {
                    visited.insert(knots[currentIdx])
                }
            }
        }
        
        return visited
    }
}

extension Point {
    func isNeighbor(of point: Point) -> Bool {
        if self == point {
            return true
        } else if self.x == point.x && abs(self.y - point.y) == 1 {
            return true
        } else if self.y == point.y && abs(self.x - point.x) == 1 {
            return true
        } else if abs(self.x - point.x) == 1 && abs(self.y - point.y) == 1 {
            return true
        }
        
        return false
    }
    
    var description: String { "[\(x), \(y)]" }
}
