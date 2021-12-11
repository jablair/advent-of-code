//
//  Matrix.swift
//  AdventOfCode
//
//  Created by Eric Blair on 12/5/21.
//

import Foundation
import Algorithms

struct Matrix<Element>: CustomStringConvertible, CustomDebugStringConvertible {
    
    enum Neighbor: CaseIterable {
        case aboveLeft
        case above
        case aboveRight
        case right
        case belowRight
        case below
        case belowLeft
        case left
        
        static var immediate: [Neighbor] { [.above, .right, .below, .left] }
    }
    
    private var data: [[Element]]
    
    var rowCount: Int { data.count }
    var colCount: Int { data.first?.count ?? 0 }
    
    init(data: [[Element]]) {
        self.data = data
    }
    
    init(repeating repeatedValue: Element, rows: Int, columns: Int) {
        self.data = (0..<rows).map { _ in
            Array<Element>(repeating: repeatedValue, count: columns)
        }
    }
    
    func count(where predicate: (Element) throws -> Bool) rethrows -> Int {
        return try data
            .map { try $0.count(where: predicate) }
            .reduce(0, +)
    }
    
    func items(where predicate: (Element, Point) throws -> Bool) rethrows -> [(Element, Point)] {
        var results: [(Element, Point)] = []
        
        for (row, col) in product(0..<rowCount, 0..<colCount) {
            if try predicate(self[row, col], Point(row: row, col: col)) {
                results.append((self[row, col], Point(row: row, col: col)))
            }
        }
        
        return results

    }
    
    func neighbor(_ neighbor: Neighbor, of row: Int, col: Int) -> (Element, Point)? {
        let neighborRow: Int
        let neighborCol: Int
        switch neighbor {
        case .aboveLeft:
            neighborRow = row - 1
            neighborCol = col - 1
        case .above:
            neighborRow = row - 1
            neighborCol = col
        case .aboveRight:
            neighborRow = row - 1
            neighborCol = col + 1
        case .right:
            neighborRow = row
            neighborCol = col + 1
        case .belowRight:
            neighborRow = row + 1
            neighborCol = col + 1
        case .below:
            neighborRow = row + 1
            neighborCol = col
        case .belowLeft:
            neighborRow = row + 1
            neighborCol = col - 1
        case .left:
            neighborRow = row
            neighborCol = col - 1
        }
        
        guard (0..<rowCount).contains(neighborRow), (0..<colCount).contains(neighborCol) else {
            return nil
        }
        
        return (self[neighborRow, neighborCol], Point(row: neighborRow, col: neighborCol))
    }
    
    subscript(row row: Int) -> [Element] {
        get { data[row] }
    }
    
    subscript(row: Int, col: Int) -> Element {
        get { data[row][col] }
        set { data[row][col] = newValue }
    }
    
    subscript(point: Point) -> Element {
        get { data[point.row][point.col] }
        set { data[point.row][point.col] = newValue }
    }
    
    subscript(indexPath: IndexPath) -> Element {
        get { data[indexPath.row][indexPath.column] }
        set { data[indexPath.row][indexPath.column] = newValue }
    }
    
    // MARK: CustomStringConvertible
    var description: String {
        let rows = data.map { row -> String in
            let rowDescription = row
                .map { String(describing: $0) }
                .joined(separator: " ")
            return "[\(rowDescription)]"
        }
        
        return "[\(rows.joined(separator: "\n "))]"
    }
    
    var debugDescription: String {
        """
        Dim: \(rowCount) x \(colCount)
        \(description)
        """
    }
}

extension Matrix where Element: Equatable {
    func items(for value: Element) -> [(Element, Point)] {
        var results: [(Element, Point)] = []
        
        for (row, col) in product(0..<rowCount, 0..<colCount) {
            if self[row, col] == value {
                results.append((value, Point(row: row, col: col)))
            }
        }
        
        return results
    }
}
