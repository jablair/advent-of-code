//
//  Day12Tests.swift
//  Day12Tests
//

import XCTest

class Day12Tests: XCTestCase {
    let day = Day12()
    let input = """
    Sabqponm
    abcryxxl
    accszExk
    acctuvwj
    abdefghi
    """

    override func setUp() async throws {
        try day.setup(input)
    }
    
    func testPart1() async throws {
        let result = try await day.part1(input)
        XCTAssertEqual(result, 31)
    }

    func testPart2() async throws {
        let result = try await day.part2(input)
        XCTAssertEqual(result, 29)
    }

}
