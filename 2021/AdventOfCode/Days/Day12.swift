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
        
        var vertices: Set<String> = []
        pathDefinitions.forEach { path in
            vertices.insert(path[0])
            vertices.insert(path[1])
        }
        
        let outputPaths = findCavePaths(paths: paths)
                
        return outputPaths.count
    }
    
    func findCavePaths(paths: [String: [String]]) -> [[String]] {
        let smallCaveRemaining: [String: Int] = paths.keys.reduce(into: [:]) { partialResult, key in
            guard key.first?.isLowercase == true else {
                return
            }
            
            partialResult[key] = 1
        }
        
        return findPaths(from: "start", in: paths, smallCaveRemaining: smallCaveRemaining)
    }
    
    func findPaths(from start: String, in paths: [String: [String]], smallCaveRemaining: [String: Int]) -> [[String]] {
        var smallCaveRemaining = smallCaveRemaining

        let destinations = paths[start, default: []]
            .filter {
                guard $0.first?.isLowercase == true else {
                    return true
                }
                return smallCaveRemaining[$0] != 0
            }
        if start.first?.isLowercase == true {
            smallCaveRemaining[start, default: 1] -= 1
        }
        
        var outputPaths: [[String]] = []
        for destination in destinations {
            if destination == "end" {
                outputPaths.append([start, "end"])
            } else {
                let subpaths = findPaths(from: destination, in: paths, smallCaveRemaining: smallCaveRemaining)
                for subpath in subpaths {
                    outputPaths.append([start] + subpath)
                }
            }
        }
        
        return outputPaths
    }
    
    func part2(_ input: String) -> CustomStringConvertible {
        return 0
    }
}
