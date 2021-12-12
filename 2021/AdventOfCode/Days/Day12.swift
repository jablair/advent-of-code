//
//  Day12.swift
//  AdventOfCode
//

import Foundation

final class Day12: Day {
    func part1(_ input: String) -> CustomStringConvertible {
        let pathDefinitions = input
            .components(separatedBy: "\n")
            .map { $0.components(separatedBy: "-") }
        
        var paths: [String: [String]] = [:]
        for def in pathDefinitions {
            paths[def[0], default: []].append(def[1])
            paths[def[1], default: []].append(def[0])
        }
        
        return findCavePaths(paths: paths).count
    }
    
    func part2(_ input: String) -> CustomStringConvertible {
        let pathDefinitions = input
            .components(separatedBy: "\n")
            .map { $0.components(separatedBy: "-") }
        
        var paths: [String: [String]] = [:]
        for def in pathDefinitions {
            paths[def[0], default: []].append(def[1])
            paths[def[1], default: []].append(def[0])
        }
        
        return findCavePaths(paths: paths, maxSmallVisit: 2).count
    }

    func findCavePaths(paths: [String: [String]], maxSmallVisit: Int = 1) -> [[String]] {
        let smallCaveRemaining: [String: Int] = paths.keys.reduce(into: [:]) { partialResult, key in
            guard key.first?.isLowercase == true else {
                return
            }
            
            if key == "start" || key == "end" {
                partialResult[key] = 1
            } else {
                partialResult[key] = maxSmallVisit
            }
        }
        
        return findPaths(from: "start", in: paths, smallCaveRemaining: smallCaveRemaining, maxSmallVisit: maxSmallVisit)
    }
    
    func findPaths(from start: String, in paths: [String: [String]], smallCaveRemaining: [String: Int], maxSmallVisit: Int) -> [[String]] {
        var smallCaveRemaining = smallCaveRemaining
        
        var destinations = paths[start, default: []]
            .filter {
                guard $0.first?.isLowercase == true else {
                    return true
                }
                return smallCaveRemaining[$0] != 0
            }
        
        if start.first?.isLowercase == true {
            smallCaveRemaining[start, default: maxSmallVisit] -= 1
        }
        
        if maxSmallVisit > 1 {
            // If we're allowing multiple visits, the implict limit is that we
            // can only exhause a single cave. If the problem was "visit 1 cave up
            // to three times, all others once", then this solution wouldn't work
            let exhaustedVisits = smallCaveRemaining.count { entry in
                let (key, value) = entry
                guard key != "start" else {
                    return false
                }
                return value == 0
            }
            
            if exhaustedVisits >= 2 {
                destinations = []
            }
        }
        
        var outputPaths: [[String]] = []
        for destination in destinations {
            if destination == "end" {
                outputPaths.append([start, "end"])
            } else {
                let subpaths = findPaths(from: destination, in: paths, smallCaveRemaining: smallCaveRemaining, maxSmallVisit: maxSmallVisit)
                for subpath in subpaths {
                    outputPaths.append([start] + subpath)
                }
            }
        }
        
        return outputPaths
    }
    
}
