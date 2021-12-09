//
//  Matrix.swift
//  AdventOfCode
//
//  Created by Eric Blair on 12/5/21.
//

import Foundation

struct Matrix<Element>: CustomStringConvertible, CustomDebugStringConvertible {
    
    enum Neighbor: CaseIterable {
        case above
        case right
        case below
        case left
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
    
    func neighbor(_ neighbor: Neighbor, of row: Int, col: Int) -> (Element, Point)? {
        let neighborRow: Int
        let neighborCol: Int
        switch neighbor {
        case .above:
            neighborRow = row - 1
            neighborCol = col
        case .right:
            neighborRow = row
            neighborCol = col + 1
        case .below:
            neighborRow = row + 1
            neighborCol = col
        case .left:
            neighborRow = row
            neighborCol = col - 1
        }
        
        guard (0..<rowCount).contains(neighborRow), (0..<colCount).contains(neighborCol) else {
            return nil
        }
        
        return (self[neighborRow, neighborCol], Point(row: neighborRow, col: neighborCol))
    }
    
    subscript(row: Int, col: Int) -> Element {
        get { data[row][col] }
        set { data[row][col] = newValue }
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
