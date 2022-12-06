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
