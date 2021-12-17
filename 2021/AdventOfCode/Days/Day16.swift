//
//  Day16.swift
//  AdventOfCode
//

import Foundation
@testable import ArgumentParser

protocol Packet {
    var version: Int { get }

    var value: Int { get }
    var cumulativeVersion: Int { get }
}


final class Day16: Day {
    
    enum TypeID: Int {
        case sum
        case product
        case minimum
        case maximum
        case literal
        case greaterThan
        case lessThan
        case equal
        
        var isOperator: Bool { self != .literal }
    }

    struct Literal: Packet {
        let version: Int
        let value: Int
        
        var cumulativeVersion: Int { version }
    }

    struct Operator: Packet {
        let version: Int
        let type: TypeID
        let subpackets: [Packet]
        
        var value: Int {
            let subvalues = subpackets.map(\.value)
            switch type {
            case .sum:
                return subvalues.sum()
            case .product:
                return subvalues.product()
            case .minimum:
                return subvalues.min() ?? 0
            case .maximum:
                return subvalues.max() ?? 0
            case .greaterThan:
                return subvalues[0] > subvalues[1] ? 1 : 0
            case .lessThan:
                return subvalues[0] < subvalues[1] ? 1 : 0
            case .equal:
                return subvalues[0] == subvalues[1] ? 1 : 0
            case .literal:
                return -1
            }
        }

        var cumulativeVersion: Int {
            return version + subpackets.map(\.cumulativeVersion).reduce(0, +)
        }
    }

    let map: [Character: [Bool]] = [
        "0": [false, false, false, false],
        "1": [false, false, false, true],
        "2": [false, false, true,  false],
        "3": [false, false, true,  true],
        "4": [false, true,  false, false],
        "5": [false, true,  false, true],
        "6": [false, true,  true,  false],
        "7": [false, true,  true,  true],
        "8": [true, false,  false, false],
        "9": [true, false,  false, true],
        "A": [true, false,  true,  false],
        "B": [true, false,  true,  true],
        "C": [true, true,   false, false],
        "D": [true, true,   false, true],
        "E": [true, true,   true,  false],
        "F": [true, true,   true,  true]
    ]
    
    private func parse(binary: inout [Bool]) -> Packet {
        let version = Int(bits: binary.popBits(3))
        let type = TypeID(rawValue: Int(bits: binary.popBits(3)))!
        
        let packet: Packet
        if type.isOperator {
            let lengthType = binary.removeFirst()
            var subpackets: [Packet] = []
            if !lengthType {
                let length = Int(bits: binary.popBits(15))
                var subpacketBits = binary.popBits(length)
                while !subpacketBits.isEmpty {
                    subpackets.append(parse(binary: &subpacketBits))
                }
                
            } else {
                let length = Int(bits: binary.popBits(11))
                (0..<length).forEach { _ in
                    subpackets.append(parse(binary: &binary))
                }
            }

            packet = Operator(version: version, type: type, subpackets: subpackets)
        } else {
            var literal: [Bool] = []
            
            var more = true
            repeat {
                more = binary.removeFirst()
                literal += binary.popBits(4)
            } while more
            
            packet = Literal(version: version, value: Int(bits: literal))
        }
        
        return packet
    }
    
    func part1(_ input: String) -> CustomStringConvertible {
        var binary = input.reduce(into: []) { converted, char in
            converted += map[char, default: []]
        }
        
        let packet = parse(binary: &binary)
        return packet.cumulativeVersion
    }

    func part2(_ input: String) -> CustomStringConvertible {
        var binary = input.reduce(into: []) { converted, char in
            converted += map[char, default: []]
        }
        
        let packet = parse(binary: &binary)
        return packet.value
    }
}

extension Array where Element == Bool {
    mutating func popBits(_ length: Int) -> [Element] {
        return (0..<length).reduce(into: []) { bits, _ in
            bits.append(removeFirst())
        }
    }
}
