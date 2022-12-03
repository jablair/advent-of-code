//
//  Day3.swift
//  AdventOfCode
//

import Foundation
import Algorithms

final class Day3: Day {
    func part1(_ input: String) async throws -> Int {
        return input
            .lines
            .map {
                let mid = $0.index($0.startIndex, offsetBy: $0.count / 2)
                return (Set($0[..<mid]), Set($0[mid...]))
            }.compactMap { $0.0.intersection($0.1).first }
            .map { value(of: $0) }
            .sum()
    }

    func part2(_ input: String) async throws -> Int {
        return input
            .lines
            .map(Set.init)
            .chunks(ofCount: 3)
            .compactMap {
                $0[$0.startIndex]
                    .intersection($0[$0.index($0.startIndex, offsetBy: 1)])
                    .intersection($0[$0.index($0.startIndex, offsetBy: 2)])
                    .first
            }.map { value(of: $0) }
            .sum()
    }
    
    private func value(of char: Character) -> Int {
        guard let dupeVal = char.lowercased().first!.asciiValue else { return 0 }
        let value = Int(dupeVal - ("a" as Character).asciiValue! + 1)
        return char.isLowercase ? value : value + 26
    }
    
}
