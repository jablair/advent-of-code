//
//  Day7.swift
//  AdventOfCode
//

import Foundation

final class Day7: Day {
    func part1(_ input: String) -> CustomStringConvertible {
        let positions = input
            .components(separatedBy: ",")
            .compactMap(Int.init)
        
        var minFuel = Int.max
        for i in (positions.min() ?? 0)...(positions.max() ?? 0) {
            let distance = positions
                .map { abs($0 - i) }
                .reduce(0, +)
            minFuel = min(distance, minFuel)
        }
        
        return minFuel
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let positions = input
            .components(separatedBy: ",")
            .compactMap(Int.init)
        
        var minFuel = Int.max
        for i in (positions.min() ?? 0)...(positions.max() ?? 0) {
            let distance = positions
                .map {
                    let move = abs($0 - i)
                    let cost = move * (1 + move)/2
                    return cost
                }
                .reduce(0, +)
            minFuel = min(distance, minFuel)
        }
        
        return minFuel
    }
}
