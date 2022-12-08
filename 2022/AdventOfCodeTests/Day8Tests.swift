//
//  Day8Tests.swift
//  Day8Tests
//

import XCTest

class Day8Tests: XCTestCase {
    let day = Day8()
    let input = """
    30373
    25512
    65332
    33549
    35390
    """

    override func setUp() async throws {
        try day.setup(input)
    }
    
    func testPart1() async throws {
        let result = try await day.part1(input)
        XCTAssertEqual(result, 21)
    }

    func testPart2() async throws {
        let result = try await day.part2(input)
        XCTAssertEqual(result, 8)
    }

}
