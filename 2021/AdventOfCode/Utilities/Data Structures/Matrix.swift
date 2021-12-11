//
//  Matrix.swift
//  AdventOfCode
//
//  Created by Eric Blair on 12/5/21.
//

import Foundation
import Algorithms

struct Matrix<Element>: Sequence, CustomStringConvertible, CustomDebugStringConvertible {
    
    enum Neighbor: CaseIterable {
        case northeast
        case north
        case northwest
        case west
        case southwest
        case south
        case southeast
        case east
        
        static var cardinal: [Neighbor] { [.north, .west, .south, .east] }
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
    
    func makeIterator() -> MatrixIterator<Element> {
        MatrixIterator(self)
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
        case .northeast:
            neighborRow = row - 1
            neighborCol = col - 1
        case .north:
            neighborRow = row - 1
            neighborCol = col
        case .northwest:
            neighborRow = row - 1
            neighborCol = col + 1
        case .west:
            neighborRow = row
            neighborCol = col + 1
        case .southwest:
            neighborRow = row + 1
            neighborCol = col + 1
        case .south:
            neighborRow = row + 1
            neighborCol = col
        case .southeast:
            neighborRow = row + 1
            neighborCol = col - 1
        case .east:
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

struct MatrixIterator<Element>: IteratorProtocol {

    fileprivate let matrix: Matrix<Element>
    private var current: Point = Point(row: 0, col: 0)

    init(_ matrix: Matrix<Element>) {
        self.matrix = matrix
    }
    
    mutating func next() -> Element? {
        guard current.row < matrix.rowCount else {
            return nil
        }
        
        let value = matrix[current]
        
        if current.col + 1 < matrix.colCount {
            current = Point(row: current.row, col: current.col + 1)
        } else {
            current = Point(row: current.row + 1, col: 0)
        }
        
        return value
    }
    
}
