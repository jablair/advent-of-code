//
//  Helpers.swift
//  AdventOfCode
//
//  Created by Eric Blair on 12/1/21.
//

import Foundation

extension IndexPath {
    var column: Int { item }
    var row: Int { section }
    
    init(column: Int, row: Int) {
        self.init(item: column, section: row)
    }
}
