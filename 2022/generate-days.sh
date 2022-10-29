#!/bin/bash

for DAY in {2..25}
do
    cat <<EOT > AdventOfCode/Days/Day${DAY}.swift
//
//  Day${DAY}.swift
//  AdventOfCode
//

import Foundation

final class Day${DAY}: Day {
    func part1(_ input: String) async throws -> Int {
        return 0
    }

    func part2(_ input: String) async throws -> Int {
        return 0
    }
}
EOT

    cat <<EOT > AdventOfCodeTests/Day${DAY}Tests.swift
//
//  Day${DAY}Tests.swift
//  Day${DAY}Tests
//

import XCTest

class Day${DAY}Tests: XCTestCase {
    let day = Day${DAY}()

    func testPart1() async throws {
        let result = try await day.part1("")
        debugPrint(result)
    }

    func testPart2() async throws {
        let result = try await day.part2("")
        debugPrint(result)
    }

}
EOT
done
