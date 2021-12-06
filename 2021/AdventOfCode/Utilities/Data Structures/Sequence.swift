//
//  Sequence.swift
//  AdventOfCode
//
//  Created by Eric Blair on 12/5/21.
//

import Foundation

extension Sequence {
    func count(where predicate: (Element) throws -> Bool) rethrows -> Int {
        return try self.filter(predicate).count
    }
}

