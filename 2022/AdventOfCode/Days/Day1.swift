//
//  Day1.swift
//  AdventOfCode
//

import Foundation
import Algorithms

final class Day1: Day {
    var elves: [[Int]]!
    var loads: [Int]!
    
    func setup(_ input: String) throws {
        elves = input
            .components(separatedBy: "\n\n")
            .map { $0.components(separatedBy: "\n").compactMap(Int.init) }
        loads = elves.map { $0.sum() }
    }
    
    func part1(_ input: String) async throws -> Int {
        return loads.max() ?? 0
    }

    func part2(_ input: String) async throws -> Int {
        return loads.max(count: 3).sum()
    }
}
