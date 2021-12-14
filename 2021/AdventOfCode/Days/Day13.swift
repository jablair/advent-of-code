//
//  Day13.swift
//  AdventOfCode
//

import Foundation
import RegularExpressionDecoder

final class Day13: Day {
    enum Fold: Decodable {
        enum CodingKeys: String, CodingKey {
            case axis
            case coordinate
        }
        
        case x(Int)
        case y(Int)
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            let axis = try container.decode(String.self, forKey: .axis)
            let coordinate = try container.decode(Int.self, forKey: .coordinate)
            
            switch axis {
            case "x":
                self = .x(coordinate)
            case "y":
                self = .y(coordinate)
            default:
                throw DecodingError.dataCorruptedError(forKey: .axis, in: container, debugDescription: "Unexpected axis \(axis)")
            }

        }
    }

    let foldPattern: RegularExpressionPattern<Fold, Fold.CodingKeys> = #"""
    fold\salong\s
    (?<\#(.axis)>[xy])=
    (?<\#(.coordinate)>\d+)
    """#

    func part1(_ input: String) throws -> CustomStringConvertible {
        let input = input.components(separatedBy: "\n\n")
        
        let marks = input[0]
            .components(separatedBy: "\n")
            .map { line -> Point in
                let coordinates = line.split(separator: ",")
                return Point(x: Int(coordinates[0])!, y: Int(coordinates[1])!)
            }
        
        let decoder = try RegularExpressionDecoder<Fold>(pattern: foldPattern, options: .allowCommentsAndWhitespace)
        let folds = try decoder.decode([Fold].self, from: input[1])
        
        guard let rows = marks.map(\.row).max(),
              let columns = marks.map(\.col).max() else {
                  return "Error"
              }
        
        var instructions = Matrix<Bool>(repeating: false, rows: rows + 1, columns: columns + 1)
        
        marks.forEach {
            instructions[$0] = true
        }
        
        switch folds[0] {
        case .x(let column):
            instructions.fold(col: column) { $0 || $1 ?? false }
        case .y(let row):
            instructions.fold(row: row)  { $0 || $1 ?? false }
        }
        
        return instructions.count { $0 }
    }

    func part2(_ input: String) throws -> CustomStringConvertible {
        let input = input.components(separatedBy: "\n\n")
        
        let marks = input[0]
            .components(separatedBy: "\n")
            .map { line -> Point in
                let coordinates = line.split(separator: ",")
                return Point(x: Int(coordinates[0])!, y: Int(coordinates[1])!)
            }
        
        let decoder = try RegularExpressionDecoder<Fold>(pattern: foldPattern, options: .allowCommentsAndWhitespace)
        let folds = try decoder.decode([Fold].self, from: input[1])
        
        guard let rows = marks.map(\.row).max(),
              let columns = marks.map(\.col).max() else {
                  return "Error"
              }
        
        var instructions = Matrix<Bool>(repeating: false, rows: rows + 1, columns: columns + 1)
        
        marks.forEach {
            instructions[$0] = true
        }
        
        folds.forEach { fold in
            switch fold {
            case .x(let column):
                instructions.fold(col: column) { $0 || $1 ?? false }
            case .y(let row):
                instructions.fold(row: row)  { $0 || $1 ?? false }
            }
        }
        
        printOutput(instructions: instructions)
        
        return instructions
    }
    
    func printOutput(instructions: Matrix<Bool>) {
        for row in 0..<instructions.rowCount {
            let outputRow = instructions[row: row]
                .map { $0 ? "#" : " " }
                .joined()
            print(outputRow)
        }
    }
}
