//
//  Day10.swift
//  AdventOfCode
//

import Foundation
import Algorithms
import Parsing

final class Day10: Day {
    enum Instruction {
        case noop
        case addx(Int)
        
        var cycles: Int {
            switch self {
            case .noop: return 1
            case .addx: return 2
            }
        }
        
        var value: Int {
            switch self {
            case .noop: return 0
            case .addx(let value): return value
            }
        }
    }
    
    var instructions: [Instruction]!
    var registers: [Int: Int] = [:]
    
    func setup(_ input: String) throws {
        let noopParser = Parse {
            "noop"
        }.map { Instruction.noop }
        
        let addxParser = Parse {
            "addx "
            Int.parser()
        }.map { Instruction.addx($0) }
        
        let instructionParser = Parse {
            Many {
                OneOf {
                    noopParser
                    addxParser
                }
            } separator: {
                Whitespace(1, .vertical)
            }
        }
        
        instructions = try instructionParser.parse(input)
        var cycle = 0
        var current = 1
        registers[0] = current

        for instruction in instructions {
            cycle += instruction.cycles
            
            if case let .addx(change) = instruction {
                current += change
                registers[cycle] = current
            }
        }
    }
    
    func part1(_ input: String) async throws -> Int {
        return [20, 60, 100, 140, 180, 220]
            .map { registers.value(for: $0) * $0 }
            .sum()
    }

    func part2(_ input: String) async throws -> String {
        var screen: Matrix<Character> = Matrix(repeating: ".", rows: 6, columns: 40)
        
        (0..<screen.rowCount).forEach { row in
            (0..<screen.colCount).forEach { col in
                let register = (col + 1) + screen.colCount * row
                let value = registers.value(for: register)
                
                let sprite = value-1...(value+1)
                
                if sprite.contains(col) {
                    screen[row, col] = "#"
                }
            }
        }
        return screen.packedDescription
    }
}

private extension Dictionary where Key == Int, Value == Int {
    func value(for cycle: Int) -> Value {
        let key = keys.filter { $0 < cycle }.max()!
        return self[key] ?? 0
    }
}
