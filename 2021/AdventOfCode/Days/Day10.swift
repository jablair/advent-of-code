//
//  Day10.swift
//  AdventOfCode
//

import Foundation

final class Day10: Day {
    let startChars = Set("([{<")
    let endChars = Set(")]}>")
    let commandPairs: [Character: Character] = ["(": ")", "[": "]", "{": "}", "<": ">"]
    
    func part1(_ input: String) -> CustomStringConvertible {
        func score(for char: Character) -> Int? {
            switch char {
            case ")": return 3
            case "]": return 57
            case "}": return 1197
            case ">": return 25137
            default: return nil
            }
        }
        
        let illegalCharScores = input
            .components(separatedBy: "\n")
            .compactMap { line -> Int? in
                var commandStack: [Character] = []
                for char in line {
                    if startChars.contains(char) {
                        // Start of new command
                        commandStack.append(char)
                    } else {
                        if let lastStart = commandStack.last {
                            if commandPairs[lastStart] == char {
                                commandStack.removeLast() // end char paired with last start, legal
                            } else {
                                return score(for: char) // mismatch between end char and char
                            }
                        } else {
                            return score(for: char) // first char is end char, illegal
                        }
                        
                    }
                }
                
                return nil
            }
        
        return illegalCharScores.reduce(0, +)
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let incompleteChars = input
            .components(separatedBy: "\n")
            .compactMap { line -> [Int]? in
                var commandStack: [Character] = []
                for char in line {
                    if startChars.contains(char) {
                        // Start of new command
                        commandStack.append(char)
                    } else {
                        if let lastStart = commandStack.last {
                            if commandPairs[lastStart] == char {
                                commandStack.removeLast() // end char paired with last start, legal
                            } else {
                                return nil
                            }
                        } else {
                            return nil // first char is end char, illegal
                        }
                        
                    }
                }
                
                return commandStack
                    .reversed()
                    .compactMap { startCommand -> Int? in
                        guard let closingCommand = commandPairs[startCommand] else {
                            return nil
                        }
                        
                        switch closingCommand {
                        case ")": return 1
                        case "]": return 2
                        case "}": return 3
                        case ">": return 4
                        default: return nil
                        }
                    }
            }
        
        let scores = incompleteChars
            .map {
                $0.reduce(0) { partialResult, score in
                    partialResult * 5 + score
                }
            }
            .sorted()
        
        return scores[(scores.count - 1) / 2]
    }
}

