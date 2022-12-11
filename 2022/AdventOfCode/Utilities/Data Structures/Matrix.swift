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
    
    fileprivate var data: [[Element]]
    
    var rowCount: Int { data.count }
    var colCount: Int { data.first?.count ?? 0 }
    
    var rowIndices: Range<Int> { 0..<rowCount }
    var colIndices: Range<Int> { 0..<colCount }
    
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
        
        for (row, col) in Algorithms.product(0..<rowCount, 0..<colCount) {
            if try predicate(self[row, col], Point(row: row, col: col)) {
                results.append((self[row, col], Point(row: row, col: col)))
            }
        }
        
        return results

    }
    
    func neighbors(_ neighbors: [Neighbor], of point: Point) -> [(Element, Point)] {
        neighbors.compactMap { neighbor($0, of: point.row, col: point.col) }
    }
    
    func neighbors(_ neighbors: [Neighbor], of row: Int, col: Int) -> [(Element, Point)] {
        neighbors.compactMap { neighbor($0, of: row, col: col) }
    }

    func neighbor(_ neighbor: Neighbor, of point: Point) -> (Element, Point)? {
        self.neighbor(neighbor, of: point.row, col: point.col)
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
    
    func expanded(by: Int, insertedValue: Element) -> Matrix<Element> {
        guard by > 0 else {
            return self
        }
        
        var expandedData = data
        for _ in 0..<by {
            for idx in expandedData.indices {
                expandedData[idx].insert(insertedValue, at: 0)
                expandedData[idx].append(insertedValue)
            }
        }
        
        for _ in 0..<by {
            let newRow = Array<Element>(repeating: insertedValue, count: expandedData[0].count)
            expandedData.insert(newRow, at: 0)
            expandedData.append(newRow)
        }

        return Matrix(data: expandedData)
    }
    
    mutating func fold(row: Int, combining: (Element, Element?) -> Element) {
        var splitData = Array(data[0..<row])
        let foldData = data[row..<rowCount].dropFirst()
        
        
        var currSplitRow = splitData.count - 1
        var currFoldRow = foldData.startIndex
        while currSplitRow >= 0 {
            let foldRow = currFoldRow < foldData.endIndex ? foldData[currFoldRow] : nil
            
            splitData[currSplitRow] = splitData[currSplitRow].enumerated().map { item -> Element in
                let (index, value) = item
                return combining(value, foldRow?[index])
            }
            
            currSplitRow -= 1
            currFoldRow = foldData.index(after: currFoldRow)
        }
        
        data = splitData
    }
    
    mutating func fold(col splitCol: Int, combining: (Element, Element?) -> Element) {
        var splitData: [[Element]] = []
        var foldData: [[Element]] = []
        
        for row in 0..<rowCount {
            let currentSplitRow: [Element] = Array(self[row: row].prefix(splitCol))
            let currentFoldRow: [Element] = Array(self[row: row][splitCol..<colCount].dropFirst())
            
            splitData.append(currentSplitRow)
            foldData.append(currentFoldRow)
        }

        let splitDataWidth = splitData.first?.count ?? 0
        for row in 0..<splitData.count {
            splitData[row] = splitData[row].enumerated().map {
                let (index, value) = $0
                let foldRow = foldData[row]

                let foldValue: Element?
                let foldDataIndex = (splitDataWidth - index - 1)
                if foldRow.indices.contains(foldDataIndex) {
                    foldValue = foldRow[foldDataIndex]
                } else {
                    foldValue = nil
                }

                return combining(value, foldValue)
            }
        }
        
        data = splitData
    }
    
    // MARK: Subscripts
    subscript(row row: Int) -> [Element] { data[row] }
    
    subscript(col col: Int) ->  [Element] { data.map { $0[col] } }
    
    subscript(row: Int, col: Int) -> Element {
        get { data[row][col] }
        set { data[row][col] = newValue }
    }
    
    subscript(point: Point) -> Element {
        get { data[point.row][point.col] }
        set { data[point.row][point.col] = newValue }
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

extension Matrix where Element == Character {
    var packedDescription: String {
        data.map { String($0) }.joined(separator: "\n")
    }
}

extension Matrix: Equatable where Element: Equatable {
    func items(for value: Element) -> [(Element, Point)] {
        var results: [(Element, Point)] = []
        
        for (row, col) in Algorithms.product(0..<rowCount, 0..<colCount) {
            if self[row, col] == value {
                results.append((value, Point(row: row, col: col)))
            }
        }
        
        return results
    }
}

extension Matrix where Element: Comparable {
    func max() -> Element? {
        return data
            .compactMap { $0.max() }
            .max()
    }
    
    func min() -> Element? {
        return data
            .compactMap { $0.min() }
            .min()
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
