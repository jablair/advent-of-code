//
//  Day14.swift
//  AdventOfCode
//

import Foundation
import RegularExpressionDecoder

final class Day14: Day {
    enum Error: Swift.Error {
        case countFailure
    }
    
    struct Rule: Decodable {
        enum CodingKeys: String, CodingKey {
            case pattern
            case insertion
        }
        
        let pattern: String
        let insertion: String
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.pattern = try container.decode(String.self, forKey: .pattern)
            self.insertion = try container.decode(String.self, forKey: .insertion)
        }
    }

    let rulePattern: RegularExpressionPattern<Rule, Rule.CodingKeys> = #"""
    \b
    (?<\#(.pattern)>\w{2})\s
    ->\s
    (?<\#(.insertion)>\w)
    \b
    """#
    
    func parse(input: String) throws -> (String, [String: String]) {
        let input = input.components(separatedBy: "\n\n")
        let polymerTemplate = input[0]
        
        let decoder = try RegularExpressionDecoder(pattern: rulePattern, options: .allowCommentsAndWhitespace)
        let rules: [String: String] = try decoder
            .decode([Rule].self, from: input[1])
            .reduce(into: [:]) { result, rule in
                result[rule.pattern] = rule.insertion
            }
        
        return (polymerTemplate, rules)
    }

    func part1(_ input: String) throws -> CustomStringConvertible {
        let (polymerTemplate, rules) = try parse(input: input)
        let minMax = try generatePolymerCounts(from: polymerTemplate, rules: rules, iterations: 10)

        return minMax.1 - minMax.0
    }

    func part2(_ input: String) throws -> CustomStringConvertible {
        let (polymerTemplate, rules) = try parse(input: input)
        let minMax = try generatePolymerCounts(from: polymerTemplate, rules: rules, iterations: 40)

        return minMax.1 - minMax.0
    }
    
    func generatePolymerCounts(from template: String, rules: [String: String], iterations: Int) throws -> (Int, Int) {
        var pairCounts: [String: Int] = template.windows(ofCount: 2).reduce(into: [:]) { counts, pair in
            counts[String(pair), default: 0] += 1
        }
        
        for _ in 0..<iterations {
            let genCounts: [String: Int] = pairCounts.reduce(into: [:]) { counts, entry in
                let (pair, count) = entry
                guard let insert = rules[pair] else {
                    return
                }
                
                let pair1 = "\(pair.first!)\(insert)"
                let pair2 = "\(insert)\(pair.last!)"
                
                counts[pair1, default: 0] += count
                counts[pair2, default: 0] += count
            }
            pairCounts = genCounts
            
        }
        
        let rawCounts: [Character: Int] = pairCounts.reduce(into: [:]) { partialResult, pair in
            partialResult[pair.key.first!, default: 0] += pair.value
            partialResult[pair.key.last!, default: 0] += pair.value
        }
        
        let adjustedCounts = rawCounts
            .mapValues { value -> Int in
            if value.isEven {
                return value / 2
            } else {
                // Only the first and last character should be odd
                return (value + 1) / 2
            }
        }

        guard let minMax = adjustedCounts.minAndMax(by: { $0.value < $1.value }) else {
            throw Error.countFailure
        }

        return (minMax.0.value, minMax.1.value)
    }
}
