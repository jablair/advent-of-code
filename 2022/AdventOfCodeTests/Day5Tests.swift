//
//  Day5Tests.swift
//  Day5Tests
//

import XCTest

class Day5Tests: XCTestCase {
    let day = Day5()
    let input = [
    "    [D]    ",
    "[N] [C]    ",
    "[Z] [M] [P]",
    " 1   2   3 ",
    "",
    "move 1 from 2 to 1",
    "move 3 from 1 to 3",
    "move 2 from 2 to 1",
    "move 1 from 1 to 2"
    ].joined(separator: "\n")

    override func setUp() async throws {
        try day.setup(input)
    }
    
    func testPart1() async throws {
        let result = try await day.part1(input)
        XCTAssertEqual(result, "CMZ")
    }

    func testPart2() async throws {
        let result = try await day.part2(input)
        XCTAssertEqual(result, "MCD")
    }

}
