//
//  Day6.swift
//  AdventOfCode
//

import Foundation
import Algorithms

final class Day6: Day {
    
    private func indexAfter(input: String, chunkSize: Int) -> Int {
        let candidates = input.windows(ofCount: chunkSize)
        let index = candidates.firstIndex(where: \.allUnique)!
        
        return candidates.distance(from: candidates.startIndex, to: index) + chunkSize
    }
    
    func part1(_ input: String) async throws -> Int {
        return indexAfter(input: input, chunkSize: 4)
    }

    func part2(_ input: String) async throws -> Int {
        return indexAfter(input: input, chunkSize: 14)
    }
}
