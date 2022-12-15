//
//  Day14.swift
//  AdventOfCode
//

import Foundation
import Algorithms
import Parsing
import OrderedCollections

final class Day14: Day {
    
    struct Cavern {
        private(set) var cave: [Point: String] = [:]
        
        let startPoint = Point(x: 500, y: 0)
        
        let bottomless: Bool
        let yMax: Int
        var sandCount: Int {
            cave.map(\.value).filter { $0 == "o" }.count
        }
        
        var rendered: String {
            let xVals = cave.map(\.key.x).minAndMax()!
            let xRange = xVals.0...xVals.1
            var rendered = ""
            for y in 0...yMax {
                for x in xRange {
                    let p = Point(x: x, y: y)
                    if p == startPoint, !filled(at: startPoint) {
                        rendered += "+"
                    } else if !bottomless && y == yMax {
                        rendered += "#"
                    } else {
                        rendered += cave[p, default: "."]
                    }
                }
                rendered += "\n"
            }
            return rendered
        }
        
        init(rocks: [Point], bottomless: Bool = true) {
            self.bottomless = bottomless
            let yMax = rocks.map(\.y).max()!
            self.yMax = bottomless ? yMax : yMax + 2
            
            rocks.forEach { cave[$0] = "#" }
        }
        
        func filled(at point: Point) -> Bool {
            if !bottomless, point.y == yMax {
                return true
            }
            
            return cave[point] != nil
        }
        
        mutating func dropSand() -> Bool {
            guard !filled(at: startPoint) else {
                return false
            }
            
            var dropping = true
            var pos = startPoint
            
            while dropping {
                while !filled(at: pos), pos.y <= yMax {
                    pos.y += 1
                }
                
                pos = pos + Point(x: 0, y: -1)
                let leftCandidate = pos + Point(x: -1, y: 1)
                let rightCandidate = pos + Point(x: 1, y: 1)
                
                if pos.y >= yMax {
                    return false
                } else if !filled(at: leftCandidate) {
                    pos = leftCandidate
                } else if !filled(at: rightCandidate) {
                    pos = rightCandidate
                } else {
                    cave[pos] = "o"
                    dropping = false
                }
            }
            
            return true
        }
        
    }
    
    var rockPaths: [Point]!
    
    func setup(_ input: String) throws {
        let pathComponentParse = Parse {
            Int.parser()
            ","
            Int.parser()
        }.map { Point(x: $0, y: $1) }
        
        let pathParser = Parse {
            Many {
                pathComponentParse
            } separator: {
                " -> "
            }
        }
        
        rockPaths = try input.lines.map {
            try pathParser.parse($0)
        }.map { pathComponents in
            var path: OrderedSet<Point> = [pathComponents[0]]
            
            for (pt1, pt2) in pathComponents.adjacentPairs() {
                if pt1.isHorizontallyAligned(to: pt2)  {
                    let down = pt1.y < pt2.y
                    for y in stride(from: pt1.y, through: pt2.y, by: down ? 1 : -1) {
                        path.append(Point(x: pt1.x, y: y))
                    }
                } else {
                    let right = pt1.x < pt2.x
                    for x in stride(from: pt1.x, through: pt2.x, by: right ? 1: -1) {
                        path.append(Point(x: x, y: pt1.y))
                    }

                }
            }
            
            return path
        }.flatMap { $0 }
    }
    
    
    func part1(_ input: String) async throws -> Int {
        var cavern = Cavern(rocks: rockPaths)
        while cavern.dropSand() { }
//        print(cavern.rendered)


        return cavern.sandCount
    }

    func part2(_ input: String) async throws -> Int {
        var cavern = Cavern(rocks: rockPaths, bottomless: false)
        while cavern.dropSand() { }
//        print(cavern.rendered)


        return cavern.sandCount
    }
}
