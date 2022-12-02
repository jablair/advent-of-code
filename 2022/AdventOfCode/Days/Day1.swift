//
//  Day1.swift
//  AdventOfCode
//

import Foundation
import Algorithms

final class Day1: Day {
    var loads: [Int]!
    
    func setup(_ input: String) throws {
        loads = input
            .lines
            .split(whereSeparator: \.isEmpty)
            .map { $0.compactMap(Int.init) }
            .map { $0.sum() }
    }
    
    func part1(_ input: String) async throws -> Int {
        return loads.max() ?? 0
    }

    func part2(_ input: String) async throws -> Int {
        return loads.max(count: 3).sum()
    }
}
