//
//  Day8.swift
//  AdventOfCode
//

import Foundation
import AppKit

final class Day8: Day {
    
    enum Error: Swift.Error {
        case missingValidDigit
    }
    
    let digitRules: [Int: Set<Character>] = [
        0: Set("abcefg"),
        1: Set("cf"),
        2: Set("acdeg"),
        3: Set("acdfg"),
        4: Set("bcdf"),
        5: Set("abdfg"),
        6: Set("abdefg"),
        7: Set("acf"),
        8: Set("abcdefg"),
        9: Set("abcdfg")
    ]
    
    func part1(_ input: String) -> CustomStringConvertible {
        let outputValues = input
            .components(separatedBy: "\n")
            .map { value in
                value
                    .suffix { $0 != "|" }
                    .components(separatedBy: " ")
            }
        
        let validLengths: Set<Int> = [
            digitRules[1]?.count ?? -1,
            digitRules[4]?.count ?? -1,
            digitRules[7]?.count ?? -1,
            digitRules[8]?.count ?? -1
        ]
        let counts = outputValues.map { pattern in
            pattern.count {
                validLengths.contains($0.count)
            }
        }
        
        return counts.reduce(0, +)
    }

    struct Entry {
        let signalPattern: [Set<Character>]
        let outputValue: [Set<Character>]
        
        func firstCode(for length: Int) -> Set<Character>? {
            return signalPattern.first(where: { $0.count == length})
        }
        
        func codes(for length: Int) -> [Set<Character>] {
            let spCandidates = signalPattern.filter { $0.count == length }
            
            return Array(spCandidates)
        }
    }
    
    func part2(_ input: String) throws -> CustomStringConvertible {
        let entries = input
            .components(separatedBy: "\n")
            .map { entry -> Entry in
                let values = entry.split(separator: "|")
                return Entry(
                    signalPattern: values[0].components(separatedBy: " ").map(Set.init),
                    outputValue: values[1].components(separatedBy: " ").map(Set.init)
                )
            }
        
        let results = try entries.map { entry -> Int in
            // Extract the known digits
            guard let one = digitRules[1].map({ entry.firstCode(for: $0.count) }) ?? nil,
                  let four = digitRules[4].map({ entry.firstCode(for: $0.count) }) ?? nil,
                  let seven = digitRules[7].map({ entry.firstCode(for: $0.count) }) ?? nil,
                  let eight = digitRules[8].map({ entry.firstCode(for: $0.count) }) ?? nil else {
                      throw Error.missingValidDigit
                  }
            
            var digitMap = [
                one: 1,
                four: 4,
                seven: 7,
                eight: 8
            ]
            
            var sixSeg = Set(entry.codes(for: 6))
            var fiveSeg = Set(entry.codes(for: 5))
            
            // 6 segment digits:
            //    - 6 is not a superset of 1
            //    - 9 is a superset of 4
            //    - 0 is not a superset of 4
            // 5 segment digits:
            //    - 3 is a superset of 1
            //    - 2 is not a superset of 1, has 2 common elements with 4
            //    - 5 is not a superset of 1, has 3 common elements with 4
            
            guard sixSeg.count == 3, fiveSeg.count == 3,
                  let six = sixSeg.removeFirst(where: { !Set($0).isSuperset(of: one )}),
                  let nine = sixSeg.removeFirst(where: { Set($0).isSuperset(of: four) }),
                  let zero = sixSeg.first,
                  let three = fiveSeg.removeFirst(where: { Set($0).isSuperset(of: one) } ),
                  let two = fiveSeg.removeFirst(where: { Set($0).intersection(four).count == 2 }),
                  let five = fiveSeg.first else {
                      throw Error.missingValidDigit
            }

            digitMap[zero] = 0
            digitMap[two] = 2
            digitMap[three] = 3
            digitMap[five] = 5
            digitMap[six] = 6
            digitMap[nine] = 9
            
            let digits = entry.outputValue.compactMap { digitMap[$0] }
            return Int(digits: digits)
         }
        
        return results.reduce(0, +)
    }
}
