//
//  Day6.swift
//  AdventOfCode
//

import Foundation

final class Day6: Day {
    func part1(_ input: String) -> CustomStringConvertible {
        let fish: [Int: Int] = input
            .trimmingCharacters(in: .newlines)
            .components(separatedBy: ",")
            .compactMap(Int.init)
            .reduce(into: [:]) { map, fish in
                map[fish, default: 0] += 1
            }
        
        let replicated = replicate(fish: fish, for: 80)
        return replicated.reduce(0) { partialResult, keyValue in
            partialResult + keyValue.value
        }
        
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let fish: [Int: Int] = input
            .trimmingCharacters(in: .newlines)
            .components(separatedBy: ",")
            .compactMap(Int.init)
            .reduce(into: [:]) { map, fish in
                map[fish, default: 0] += 1
            }
        
        let replicated = replicate(fish: fish, for: 256)
        return replicated.reduce(0) { partialResult, keyValue in
            partialResult + keyValue.value
        }
    }

    private func replicate(fish: [Int: Int], for days: Int) -> [Int: Int] {
        var fish = fish
        for _ in 0..<days {
            let readyToPop = fish[0, default: 0]
            
            let pairs = fish.compactMap { key, value -> (Int, Int)? in
                if key != 0 {
                    return (key - 1, value)
                } else {
                    return nil
                }
            }
            fish = Dictionary(uniqueKeysWithValues: pairs)
            fish[6, default: 0] += readyToPop
            fish[8] = readyToPop
        }
        return fish
    }
}
