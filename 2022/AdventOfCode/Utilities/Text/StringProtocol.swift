//
//  StringProtocol.swift
//  AdventOfCode
//
//  Created by Eric Blair on 12/1/22.
//

import Foundation

extension StringProtocol {
    var lines: [String] { components(separatedBy: .newlines) }
    
    func padding(toLength length: Int, with pad: String) -> String {
        let myLength = self.count
        let missingLength = length - myLength
        if missingLength <= 0 { return String(self) }
        
        let repetitions = Int(ceil(Double(missingLength) / Double(pad.count)))
        
        var padding = String(repeating: pad, count: repetitions)
        let extra = padding.count - missingLength
        if extra > 0 {
            padding.removeLast(extra)
        }
        
        return String(self) + padding
    }
}
