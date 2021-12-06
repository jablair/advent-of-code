//
//  Helpers.swift
//  AdventOfCode
//
//  Created by Eric Blair on 12/1/21.
//

import Foundation

extension Sequence {
    func count(where predicate: (Element) throws -> Bool) rethrows -> Int {
        return try self.filter(predicate).count
    }
}

extension IndexPath {
    var column: Int { item }
    var row: Int { section }
    
    init(column: Int, row: Int) {
        self.init(item: column, section: row)
    }
}

struct Matrix<Element>: CustomStringConvertible, CustomDebugStringConvertible {
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
