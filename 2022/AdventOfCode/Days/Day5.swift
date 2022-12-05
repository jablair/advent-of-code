//
//  Day5.swift
//  AdventOfCode
//

import Foundation
import Parsing
import DequeModule

final class Day5: Day {
    
    struct Move {
        let count: Int
        let sourcec: Int
        let destination: Int
    }

    var stacks: [[Character]]! = []
    var moves: [Move]!

    func setup(_ input: String) throws {
        let segments = input.lines.split(whereSeparator: \.isEmpty)
        
        let moveParser = Parse {
            "move "
            Int.parser()
            " from "
            Int.parser()
            " to "
            Int.parser()
        }.map { Move(count: $0, sourcec: $1, destination: $2)}
        
        moves = try segments[1].map {
            try moveParser.parse($0)
        }
        
        let stackLines = segments[0]
            .map { $0.chunks(ofCount: 4) }
            .reversed()
            .dropFirst(1)
        
        let count = stackLines.first!.count
        stacks = Array(repeating: [], count: count)
        
        stackLines.forEach {
            $0.enumerated().forEach {
                let (index, element) = $0
                let crateIDIndex = element.index(element.startIndex, offsetBy: 1)
                let crate = element[crateIDIndex]
                if crate.isLetter {
                    stacks[index].append(crate)
                }
            }
        }
    }
    
    func part1(_ input: String) async throws -> String {
        var mutatedStacks = stacks!
        
        moves.forEach { move in
            for _ in 0..<move.count {
                mutatedStacks[move.destination - 1].append(mutatedStacks[move.sourcec - 1].removeLast())
            }
        }
        
        return String(mutatedStacks.compactMap { $0.last })
    }

    func part2(_ input: String) async throws -> String {
        var mutatedStacks = stacks!
        
        moves.forEach { move in
            var moving: Deque<Character> = []
            for _ in 0..<move.count {
                moving.insert(mutatedStacks[move.sourcec - 1].removeLast(), at: 0)
            }
            mutatedStacks[move.destination - 1].append(contentsOf: moving)
        }
        
        return String(mutatedStacks.compactMap { $0.last })
    }
}
