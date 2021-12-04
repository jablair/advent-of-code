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
