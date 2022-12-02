//
//  StringProtocol.swift
//  AdventOfCode
//
//  Created by Eric Blair on 12/1/22.
//

import Foundation

extension StringProtocol {
    var lines: [String] { components(separatedBy: .newlines) }
}
