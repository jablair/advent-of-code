//
//  Day4Tests.swift
//  Day4Tests
//

import XCTest

class Day4Tests: XCTestCase {
    let day = Day4()
    let input = """
    2-4,6-8
    2-3,4-5
    5-7,7-9
    2-8,3-7
    6-6,4-6
    2-6,4-8
    """
    
    override func setUp() async throws {
        try day.setup(input)
    }
    
    func testPart1() async throws {
        let result = try await day.part1(input)
        XCTAssertEqual(result, 2)
    }

    func testPart2() async throws {
        let result = try await day.part2(input)
        XCTAssertEqual(result, 4)
    }

}
