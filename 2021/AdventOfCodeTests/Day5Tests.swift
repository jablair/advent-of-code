//
//  Day5Tests.swift
//  Day5Tests
//

import XCTest

class Day5Tests: XCTestCase {
    let day = Day5()
    let input = """
    0,9 -> 5,9
    8,0 -> 0,8
    9,4 -> 3,4
    2,2 -> 2,1
    7,0 -> 7,4
    6,4 -> 2,0
    0,9 -> 2,9
    3,4 -> 1,4
    0,0 -> 8,8
    5,5 -> 8,2
    """

    func testPart1() throws {
        let result = try day.part1(input)
        XCTAssertEqual(result as? Int, 5)
    }

    func testPart2() throws {
        let result = try day.part2(input)
        XCTAssertEqual(result as? Int, 12)
    }

}
