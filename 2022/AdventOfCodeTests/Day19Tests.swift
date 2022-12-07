//
//  Day19Tests.swift
//  Day19Tests
//

import XCTest

class Day19Tests: XCTestCase {
    let day = Day19()
    let input = """
    
    """

    override func setUp() async throws {
        try day.setup(input)
    }
    
    func testPart1() async throws {
        let result = try await day.part1(input)
        XCTAssertEqual(result, 0)
    }

    func testPart2() async throws {
        let result = try await day.part2(input)
        XCTAssertEqual(result, 0)
    }

}
