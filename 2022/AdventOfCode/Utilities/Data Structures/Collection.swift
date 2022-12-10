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
    
    func countPrefix(through predicate: (Element) throws -> Bool) rethrows -> Int {
        var count = 0
        
        var iterator = makeIterator()
        while let value = iterator.next() {
            count += 1

            if try !predicate(value) {
                break
            }
        }
        
        return count
    }
    
    func countSuffix(through predicate: (Element) throws -> Bool) rethrows -> Int {
        var count = 0
        
        var iterator = reversed().makeIterator()
        while let value = iterator.next() {
            count += 1
            if try !predicate(value) {
                break
            }
        }
        
        return count
    }

}

public extension MutableCollection {
    
    mutating func mutatingMap<C>(_ action: (inout Element) -> C) -> Array<C> {
        var index = startIndex
        var result = Array<C>()
        while index != endIndex {
            var copy = self[index]
            result.append(action(&copy))
            self[index] = copy
            
            index = self.index(after: index)
        }
        return result
    }
}
