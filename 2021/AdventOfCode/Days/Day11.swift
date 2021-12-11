//
//  Day11.swift
//  AdventOfCode
//

import Foundation
import Algorithms

final class Day11: Day {
    
    private func increment(octopi: inout Matrix<Int>, at row: Int, col: Int) -> Bool {
        let currentValue = octopi[row, col]
        octopi[row, col] += 1
        
        return currentValue == 9
    }
    
    fileprivate func flash(octopi: Matrix<Int>, stop: (Int, Matrix<Int>) -> Bool) -> (Int, Int) {
        var octopi = octopi
        var flashes = 0
        
        for idx in 0... {
            var flashed: Set<Point> = []
            for (row, col) in product(0..<octopi.rowCount, 0..<octopi.colCount) {
                let point = Point(row: row, col: col)
                guard increment(octopi: &octopi, at: row, col: col/*, flashed: &flashed*/) else {
                    continue
                }
                flashed.insert(point)
            }
            
            var toProcess = flashed
            
            while !toProcess.isEmpty {
                let point = toProcess.removeFirst()
                let neighbors = Matrix.Neighbor.allCases.compactMap {
                    octopi.neighbor($0, of: point.row, col: point.col)
                }
                neighbors.forEach {
                    let (_, point) = $0
                    if increment(octopi: &octopi, at: point.row, col: point.col/*, flashed: &flashed*/) {
                        flashed.insert(point)
                        toProcess.insert(point)
                    }
                }
            }
            
            flashed.forEach { octopi[$0] = 0 }
            
            flashes += flashed.count
            
            if stop(idx + 1, octopi) {
                return (idx + 1, flashes)
            }
        }
        
        return (0, 0)
    }
    
    func part1(_ input: String) -> CustomStringConvertible {
        let octopi = input
            .components(separatedBy: "\n")
            .map { string in
                string.compactMap { Int(String($0)) }
            }
        
        let flashes = flash(octopi: Matrix(data: octopi)) { idx, _ in idx == 100 }
        return flashes.1
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let octopi = input
            .components(separatedBy: "\n")
            .map { string in
                string.compactMap { Int(String($0)) }
            }
        
        let flashes = flash(octopi: Matrix(data: octopi)) { idx, result in
            let flashedRows = (0..<result.rowCount).map {
                result[row: $0].allSatisfy { brightness in brightness == 0}
            }
            return flashedRows.allSatisfy { $0 == true }
        }
        
        return flashes.0
    }
}
