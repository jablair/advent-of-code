//
//  Day14Tests.swift
//  Day14Tests
//

import XCTest

class Day14Tests: XCTestCase {
    let day = Day14()
    let input = """
    498,4 -> 498,6 -> 496,6
    503,4 -> 502,4 -> 502,9 -> 494,9
    """

    override func setUp() async throws {
        try day.setup(input)
    }
    
    func testPart1() async throws {
        let result = try await day.part1(input)
        XCTAssertEqual(result, 24)
    }

    func testPart2() async throws {
        let result = try await day.part2(input)
        XCTAssertEqual(result, 93)
    }
}
