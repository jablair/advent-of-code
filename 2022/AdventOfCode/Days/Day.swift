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
        let overallStartDate = Date()

        let part1StartDate = Date()
        let p1 = try await part1(input)
        print("Part 1 (\(-part1StartDate.timeIntervalSinceNow * 1000) ms): \(p1)")

        let part2StartDate = Date()
        let p2 = try await part2(input)
        print("Part 2 (\(-part2StartDate.timeIntervalSinceNow * 1000) ms): \(p2)")
        print("Overall (\(-overallStartDate.timeIntervalSinceNow * 1000) ms)")
        print("")

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
