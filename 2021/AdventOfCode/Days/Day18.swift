//
//  Day18.swift
//  AdventOfCode
//

import Foundation

final class Day18: Day {
    
    enum Token: Equatable {
        case number(Int)
        case pairOpen
        case pairClose
        
        init?(_ char: Character) {
            switch char {
            case "0"..."9":
                guard let int = char.wholeNumberValue else { return nil }
                self = .number(int)
            case "[":
                self = .pairOpen
            case "]":
                self = .pairClose
            default:
                return nil
            }
        }
    }
    
    struct Equation: CustomStringConvertible {

        private(set) var tokens: [Token]
        private var index: Int = 0
        
        var description: String {
            return tokens.map { token -> String in
                switch token {
                case let .number(value):
                    return "\(value)"
                case .pairOpen:
                    return "["
                case .pairClose:
                    return "]"
                }
            }.joined()
        }
        
//        var magnitude: Int {
//          func rec(_ index: inout Int) -> Int {
//              if case let .number(value) = tokens[index] {
//              index += 1
//              return value
//            } else {
//              index += 1 // .open
//              let left = rec(&index)
//              let right = rec(&index)
//              index += 1 // .close
//              return 3 * left + 2 * right
//            }
//          }
//
//          var index = 0
//          return rec(&index)
//        }

        var magnitude: Int {
            func calcMag(_ idx: inout Int) -> Int {
                if case let .number(value) = tokens[idx] {
                    idx += 1
                    return value
                } else if case .pairOpen = tokens[idx] {
                    idx += 1
                    let left = calcMag(&idx)
                    let right = calcMag(&idx)
                    idx += 1
                    return left * 3 + right * 2
                } else {
                    return 0
                }
            }

            var idx = 0
            return calcMag(&idx)
        }
        
        init(function: String) {
            tokens = function.compactMap(Token.init)
        }
        
        mutating func reduce() {
            while true {
                if explode() {
                    continue
                }
                
                if split() {
                    continue
                }
                
                break
            }
        }
        
        mutating func explode() -> Bool {
            var depth = 0
            for (idx, token) in tokens.enumerated() {
                switch token {
                case .pairOpen:
                    depth += 1
                case .pairClose:
                    depth -= 1
                case .number:
                    break
                }
                
                guard depth == 5 else {
                    continue
                }
                
                let prevIdx = tokens[..<idx].lastIndex {
                    guard case .number = $0 else {
                        return false
                    }
                    
                    return true
                }
                
                if let prevIdx = prevIdx {
                    guard case let .number(prevVal) = tokens[prevIdx],
                          case let .number(leftVal) = tokens[idx + 1] else {
                              return false
                          }
                    tokens[prevIdx] = Token.number(prevVal + leftVal)
                }
                
                let nextIdx = tokens[(idx + 4)...].firstIndex {
                    guard case .number = $0 else {
                        return false
                    }
                    
                    return true
                }
                
                if let nextIdx = nextIdx {
                    guard case let .number(nextVal) = tokens[nextIdx],
                          case let .number(rightVal) = tokens[idx + 2] else {
                              return false
                          }
                    tokens[nextIdx] = Token.number(nextVal + rightVal)
                }
                
                tokens.replaceSubrange(idx..<(idx + 4), with: [.number(0)])
                return true
            }
            
            return false
        }
        
        mutating func split() -> Bool {
            for (idx, token) in tokens.enumerated() {
                guard case let .number(value) = token, value >= 10 else {
                    continue
                }
                
                let splitInfo = value.quotientAndRemainder(dividingBy: 2)
                let replacement: [Token] = [
                    .pairOpen,
                    .number(splitInfo.quotient),
                    .number(splitInfo.quotient + splitInfo.remainder),
                    .pairClose
                ]
                
                tokens.replaceSubrange(idx...idx, with: replacement)
                return true
            }
            
            return false
        }
        
        mutating func add(_ other: Equation) {
            tokens.insert(.pairOpen, at: 0)
            tokens.append(contentsOf: other.tokens)
            tokens.append(.pairClose)
        }
    }
    
    
    func part1(_ input: String) -> CustomStringConvertible {
        var equations = input
            .components(separatedBy: "\n")
            .map(Equation.init)
        
        var equation = equations.removeFirst()
        
        while !equations.isEmpty {
            let nextEquation = equations.removeFirst()
            
            equation.add(nextEquation)
            equation.reduce()
        }
        
        
        return equation.magnitude
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let equations = input
            .components(separatedBy: "\n")
            .map(Equation.init)
        
        var maxMag = 0
        for idx in equations.indices {
            for candidateIdx in equations.indices {
                guard idx != candidateIdx else {
                    continue
                }
                
                var equation = equations[idx]
                equation.add(equations[candidateIdx])
                equation.reduce()
                
                maxMag = max(maxMag, equation.magnitude)
            }
        }
        
        return maxMag
    }
}
