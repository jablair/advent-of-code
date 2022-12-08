//
//  Collection.swift
//  AdventOfCode
//
//  Created by Eric Blair on 12/6/22.
//

import Foundation

extension Collection where Element: Hashable {
    
    var allUnique: Bool {
        Set(self).count == count
    }
    
}

extension RandomAccessCollection where Self.Index: Strideable, Self.Index.Stride: SignedInteger {
    func countPrefix(through predicate: (Element) throws -> Bool) rethrows -> Int {
        var count = 0
        
        for idx in startIndex..<endIndex {
            count += 1
            if try !predicate(self[idx]) {
                break
            }
        }
        
        return count
    }
    
    func countSuffix(through predicate: (Element) throws -> Bool) rethrows -> Int {
        var count = 0
        
        for idx in stride(from: index(before: endIndex), through: startIndex, by: -1) {
            count += 1
            if try !predicate(self[idx]) {
                break
            }
        }
        
        return count
    }

}
