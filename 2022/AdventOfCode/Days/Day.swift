//
//  Day.swift
//  AdventOfCode
//

import Foundation

protocol Day {
    associatedtype Part1Result: CustomStringConvertible = String
    associatedtype Part2Result: CustomStringConvertible = String
    
    init()

    func setup(_ input: String) throws
    func part1(_ input: String) async throws -> Part1Result
    func part2(_ input: String) async throws -> Part2Result
    
    func run(_ input: String) async throws -> (Part1Result, Part2Result)
}

extension Day {
    func run(_ input: String) async throws -> (Part1Result, Part2Result) {
        let p1 = try await part1(input)
        let p2 = try await part2(input)
        
        return (p1, p2)
    }
    
    func setup(_ input: String) throws { }
    
    func part1(_ input: String) -> Part1Result {
        fatalError("Implementation Required")
    }
    
    func part2(_ input: String) -> Part2Result {
        fatalError("Implementation Required")
    }
}
