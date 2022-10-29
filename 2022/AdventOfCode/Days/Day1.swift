//
//  Day1.swift
//  AdventOfCode
//

import Foundation
import Algorithms

final class Day1: Day {
    enum Change {
        case increase
        case decrease
    }
    
    private func increaseCount(for entries: [Int]) -> Int {
        var changes: [Change] = []
        for (idx, entry) in entries.enumerated() {
            guard idx > entries.startIndex else {
                continue
            }
            
            changes.append(entry > entries[idx - 1] ? .increase : .decrease)
        }
        
        return changes.count { $0 == .increase }
    }
    
    func part1(_ input: String) async throws -> Int {
        let entries = input.split(separator: "\n").compactMap { Int($0) }
        return(increaseCount(for: entries))
    }

    func part2(_ input: String) async throws -> Int {
        let entries = input.split(separator: "\n").compactMap { Int($0) }
        let windowSums = entries
            .windows(ofCount: 3)
            .map { $0.reduce(0, +) }
        
        return increaseCount(for: windowSums)
    }
}
