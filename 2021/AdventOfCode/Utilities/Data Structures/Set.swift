//
//  Set.swift
//  AdventOfCode
//
//  Created by Eric Blair on 12/8/21.
//

import Foundation

public extension Set {

    mutating func removeFirst(where predicate: (Element) throws -> Bool) rethrows -> Element? {
        guard let match = try first(where: predicate) else {
            return nil
        }
        return remove(match)
    }

}
