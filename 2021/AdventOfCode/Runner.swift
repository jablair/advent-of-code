//
//  main.swift
//  AdventOfCode
//

import Foundation
import Algorithms
import ArgumentParser

@main
struct Runner: ParsableCommand {
    @Option(name: .shortAndLong, help: "The day to run")
    var day: Int?
    
    @Option(name: .shortAndLong, help: "The path to the input files")
    var inputPath: String
    
    @Flag(help: "Run all days")
    var allDays = false
    
    mutating func run() throws {
        if allDays {
            for d in 1...25 {
                try run(dayNumber: d)
            }
        } else {
            let day: Int
            if let requestedDay = self.day {
                day = requestedDay
            } else {
                day = Calendar.current.dateComponents(in: .init(identifier: "EST")!, from: .now).day!
            }
            
            try run(dayNumber: day)
        }
    }
    
    private func run(dayNumber: Int) throws {
        guard let dayClass = Bundle.main.classNamed("AdventOfCode.Day\(dayNumber)") as? Day.Type
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

        print("===Day \(dayNumber)===")

        let part1StartDate = Date()
        let part1 = try day.part1(input)
        print("Part 1 (\(-part1StartDate.timeIntervalSinceNow * 1000) ms): \(part1)")

        let part2StartDate = Date()
        let part2 = try day.part2(input)
        print("Part 2 (\(-part2StartDate.timeIntervalSinceNow * 1000) ms): \(part2)")
        print("")
    }

}
