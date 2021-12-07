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
        
        return fuelCost(from: positions) { $0 }
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let positions = input
            .components(separatedBy: ",")
            .compactMap(Int.init)
        
        return fuelCost(from: positions) { move in
            move * (1 + move)/2
        }
    }
    
    func fuelCost(from positions: [Int], costCalulator: (Int) -> Int) -> Int {
        var minFuel = Int.max
        for i in (positions.min() ?? 0)...(positions.max() ?? 0) {
            let distance = positions
                .map { costCalulator(abs($0 - i)) }
                .reduce(0, +)
            minFuel = min(distance, minFuel)
        }
        return minFuel
    }
}
