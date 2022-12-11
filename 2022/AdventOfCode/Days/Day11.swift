//
//  Day11.swift
//  AdventOfCode
//

import Foundation
import DequeModule
import Parsing

final class Day11: Day {
    
    struct Monkey {
        var items: Deque<Int>
        let operation: Operation
        let test: Test
        var inspectionCount: Int = 0
        
        init(items: Deque<Int>, operation: Operation, test: Test) {
            self.items = items
            self.operation = operation
            self.test = test
        }
    }
    
    struct Test {
        let divisor: Int
        let passing: Int
        let failing: Int
        
        func run(against: Int) -> Int {
            against % divisor == 0 ? passing : failing
        }
    }
    
    enum Operation {
        case add(Int)
        case multiply(Int)
        case square
        
        func apply(to value: Int) -> Int {
            switch self {
            case let .add(add): return value + add
            case let .multiply(multiple): return value * multiple
            case .square: return value * value
            }
        }
    }
    
    var monkeys: [Monkey]!
    
    func setup(_ input: String) throws {
        let addParser = Parse {
            "  Operation: new = old + "
            Int.parser()
        }.map { Operation.add($0) }
        
        let multParser = Parse {
            "  Operation: new = old * "
            Int.parser()
        }.map { Operation.multiply($0) }
        
        let squareParser = Parse {
            "  Operation: new = old * old"
        }.map { Operation.square }


        let opParser = Parse {
            OneOf {
                addParser
                multParser
                squareParser
            }
        }
        
        let itemParser = Parse {
            "  Starting items: "
            Many {
                Int.parser()
            } separator: {
                ", "
            }
        }
        
        let testParser = Parse {
            "  Test: divisible by "
            Int.parser()
        }
        
        let trueParser = Parse {
            "    If true: throw to monkey "
            Int.parser()
        }
        
        let falseParse = Parse {
            "    If false: throw to monkey "
            Int.parser()
        }
        
        let monkeyInput = input.lines.split(whereSeparator: \.isEmpty)
        monkeys = try monkeyInput.map { monkey in
            let items = try itemParser.parse(monkey[monkey.index(monkey.startIndex, offsetBy: 1)])
            let operation =  try opParser.parse(monkey[monkey.index(monkey.startIndex, offsetBy: 2)])
            let divisor = try testParser.parse(monkey[monkey.index(monkey.startIndex, offsetBy: 3)])
            let passing = try trueParser.parse(monkey[monkey.index(monkey.startIndex, offsetBy: 4)])
            let failing = try falseParse.parse(monkey[monkey.index(monkey.startIndex, offsetBy: 5)])
            
            return Monkey(items: Deque(items),
                          operation: operation,
                          test: Test(divisor: divisor, passing: passing, failing: failing))
        }
    }
    
    
    func part1(_ input: String) async throws -> Int {
        var monkeys = monkeys!
        
        (0..<20).forEach { round in
            runRound(for: &monkeys) { $0 / 3 }
        }
        
        let counts = monkeys.map(\.inspectionCount).sorted(by: >)
        
        return counts[0] * counts[1]
    }

    func part2(_ input: String) async throws -> Int {
        let modulo = monkeys.map(\.test.divisor).product()
        var monkeys = monkeys!

        (0..<10000).forEach { round in
            runRound(for: &monkeys) { $0 % modulo }
        }

        let counts = monkeys.map(\.inspectionCount).sorted(by: >)
        
        return counts[0] * counts[1]
    }
    
    private func runRound(for monkeys: inout [Monkey], worryCalculator: (Int) -> Int) {
        monkeys.indices.forEach { idx in
            while !monkeys[idx].items.isEmpty {
                let worryLevel = monkeys[idx].items.removeFirst()
                let newWorryLevel = worryCalculator(monkeys[idx].operation.apply(to: worryLevel))
                let destination = monkeys[idx].test.run(against: newWorryLevel)
                monkeys[idx].inspectionCount += 1
                monkeys[destination].items.append(newWorryLevel)
            }
        }
    }
    
    
}
