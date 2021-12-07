//
//  Day.swift
//  AdventOfCode
//

import Foundation

protocol Day: AnyObject {
    init()

    func part1(_ input: String) throws -> CustomStringConvertible
    func part2(_ input: String) throws -> CustomStringConvertible
}

extension Day {
    func run(_ input: String) throws -> (CustomStringConvertible, CustomStringConvertible) {
        let p1 = try part1(input)
        let p2 = try part2(input)
        
        return (p1, p2)
    }
}
