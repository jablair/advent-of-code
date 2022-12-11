//
//  main.swift
//  AdventOfCode
//

import Foundation
import Algorithms
import ArgumentParser

@main
struct Runner: AsyncParsableCommand {
    @Option(name: .shortAndLong, help: "The day to run")
    var day: Int?
    
    @Option(name: .shortAndLong, help: "The path to the input files")
    var inputPath: String
    
    @Flag(help: "Run all days")
    var allDays = false
    
    mutating func run() async throws {
        if allDays {
            for d in 1...25 {
                try await run(dayNumber: d)
            }
        } else {
            let day: Int
            if let requestedDay = self.day {
                day = requestedDay
            } else {
                day = Calendar.current.dateComponents(in: .init(identifier: "EST")!, from: .now).day!
            }
            
            try await run(dayNumber: day)
        }
    }
        
    private func run(dayNumber: Int) async throws {
        guard let dayClass = Bundle.main.classNamed("AdventOfCode.Day\(dayNumber)") as? any Day.Type
        else {
            debugPrint("Day \(dayNumber) could not be initialized")
            return
        }
        
        guard let input = try? String(
            contentsOfFile: (inputPath as NSString).appendingPathComponent("day\(dayNumber)_input.txt")
        ).trimmingCharacters(in: .newlines) else {
            debugPrint("Could not read day\(dayNumber)_input.txt file")
            return
        }
        let day = dayClass.init()

        try day.setup(input)
        
        print("===Day \(dayNumber)===")
        let d1 = Date()
        let (part1, part2) = try await day.run(input)
        let d2 = Date()
        print("Part 1: \(part1)")
        print("Part 2: \(part2)")
        print("Overall (\(d2.timeIntervalSince(d1) * 1000) ms)")
    }

}
