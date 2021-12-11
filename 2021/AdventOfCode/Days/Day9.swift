//
//  Day9.swift
//  AdventOfCode
//

import Foundation

final class Day9: Day {
    
    func lowPoints(for flows: Matrix<Int>) -> [Point] {
        var lowPoints: [Point] = []
        
        for row in 0..<flows.rowCount {
            for col in 0..<flows.colCount {
                let point = flows[row, col]
                let lowNeighbor = Matrix.Neighbor.immediate.compactMap {
                    flows.neighbor($0, of: row, col: col).map(\.0)
                }.min() ?? -1
                
                if point < lowNeighbor {
                    lowPoints.append(Point(row: row, col: col))
                }
            }
        }
        
        return lowPoints
    }
    
    func part1(_ input: String) -> CustomStringConvertible {
        let flows = input
            .components(separatedBy: "\n")
            .map { flowLine in
                return flowLine.compactMap { char in
                    return Int(String(char))
                }
            }
        
        let flowMatrix = Matrix(data: flows)
        let lowPoints = lowPoints(for: flowMatrix)
        
        return lowPoints.reduce(0) { partialResult, point in
            partialResult + flowMatrix[point.row, point.col] + 1
        }
    }
    
    func basinNeighbors(for point: Point, in flows: Matrix<Int>) -> Set<Point> {
        let pointValue = flows[point.row, point.col]
        var basinPoints: Set<Point> = [point]
        let neighbors = Matrix<Int>.Neighbor.immediate.compactMap { neighbor -> Point? in
            guard let neighborVal = flows.neighbor(neighbor, of: point.row, col: point.col),
                  ((pointValue + 1)..<9).contains(neighborVal.0) else {
                return nil
            }
            
            return neighborVal.1
        }
        
        for eachNeighbor in neighbors {
            basinNeighbors(for: eachNeighbor, in: flows).forEach { basinPoints.insert($0) }
        }
            
        return basinPoints
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let flows = input
            .components(separatedBy: "\n")
            .map { flowLine in
                return flowLine.compactMap { char in
                    return Int(String(char))
                }
            }
        
        let flowMatrix = Matrix(data: flows)
        let lowPoints = lowPoints(for: flowMatrix)
        
        let basins = lowPoints
            .map { basinNeighbors(for: $0, in: flowMatrix) }
            .sorted { $0.count > $1.count }
        
        return basins
            .prefix(3)
            .map(\.count)
            .reduce(1, *)
    }
}
