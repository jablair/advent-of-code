//
//  Day8.swift
//  AdventOfCode
//

import Foundation

final class Day8: Day {
    var trees: Matrix<Int>!
    
    func setup(_ input: String) throws {
        let trees = input
            .components(separatedBy: "\n")
            .map { string in
                string.compactMap { Int(String($0)) }
            }

        self.trees = Matrix(data: trees)
    }
    
    func part1(_ input: String) async throws -> Int {
        var visible = 0
        for r in 1..<(trees.rowCount-1) {
            for c in 1..<(trees.colCount-1) {
                let tree = trees[r, c]
                let row = trees[row: r]
                let col = trees[col: c]
                
                let left = row[0..<c]
                let right = row[(c+1)...]
                let up = col[0..<r]
                let down = col[(r+1)...]
                
                if left.max()! < tree || right.max()! < tree || up.max()! < tree || down.max()! < tree {
                    visible += 1
                }
            }
        }
        
        return 2 * trees.rowCount + 2 * trees.colCount - 4 + visible
    }

    func part2(_ input: String) async throws -> Int {
        var visibility = Matrix<Int>(repeating: 0, rows: trees.rowCount, columns: trees.colCount)
        
        for r in 1..<(trees.rowCount-1) {
            for c in 1..<(trees.colCount-1) {
                let tree = trees[r, c]
                let row = trees[row: r]
                let col = trees[col: c]
                
                let left = row[0..<c]
                let right = row[(c+1)...]
                let up = col[0..<r]
                let down = col[(r+1)...]

                let leftVis = left.countSuffix(through: { $0 < tree })
                let rightVis = right.countPrefix(through: {
                    $0 < tree
                })
                let upVis = up.countSuffix(through: { $0 < tree })
                let downVis = down.countPrefix(through: { $0 < tree })
                
                visibility[r, c] = leftVis * rightVis * upVis * downVis
            }
        }
        
        return visibility.max()!
    }
}
