//
//  Day3.swift
//  AdventOfCode
//

import Foundation
import XCTest

final class Day3: Day {
    func part1(_ input: String) -> CustomStringConvertible {
        let reports = input.split(separator: "\n")
        guard let reportLength = reports.first?.count else {
            return 0
        }
        
        var gammaRate: String = ""
        var epsilonRate: String = ""

        for idx in 0..<reportLength {
            let powerConsumption = reports.map { report in
                report[report.index(report.startIndex, offsetBy: idx)]
            }
            
            if powerConsumption.count(where: { $0 == "0"}) > powerConsumption.count / 2 {
                gammaRate.append("0")
                epsilonRate.append("1")
            } else {
                gammaRate.append("1")
                epsilonRate.append("0")
            }
        }
        
        guard let gammaRate = Int(gammaRate, radix: 2),
              let epsilonRate = Int(epsilonRate, radix: 2) else {
                  return 0
              }
        
        return gammaRate * epsilonRate
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let reports = input.split(separator: "\n")
        guard let reportLength = reports.first?.count else {
            return 0
        }
        
        var oxygenRatings = reports
        var co2Ratings = reports

        for idx in 0..<reportLength {
            let powerConsumption = oxygenRatings.map { report in
                report[report.index(report.startIndex, offsetBy: idx)]
            }

            if powerConsumption.count(where: { $0 == "1"}) >= powerConsumption.count(where: { $0 == "0"}) {
                oxygenRatings = oxygenRatings.filter {
                    $0[$0.index($0.startIndex, offsetBy: idx)] == "1"
                }
            } else {
                oxygenRatings = oxygenRatings.filter {
                    $0[$0.index($0.startIndex, offsetBy: idx)] == "0"
                }
            }
            if oxygenRatings.count == 1 {
                break
            }
        }
        
        for idx in 0..<reportLength {
            let powerConsumption = co2Ratings.map { report in
                report[report.index(report.startIndex, offsetBy: idx)]
            }
            
            if powerConsumption.count(where: { $0 == "0"}) <= powerConsumption.count(where: { $0 == "1"}) {
                co2Ratings = co2Ratings.filter {
                    $0[$0.index($0.startIndex, offsetBy: idx)] == "0"
                }
            } else {
                co2Ratings = co2Ratings.filter {
                    $0[$0.index($0.startIndex, offsetBy: idx)] == "1"
                }
            }
            
            if co2Ratings.count == 1 {
                break
            }
        }
        
        guard let oxygenRating = Int(oxygenRatings[0], radix: 2),
              let co2Rating = Int(co2Ratings[0], radix: 2) else {
                  return 0
              }
        
        return oxygenRating * co2Rating
    }
}
