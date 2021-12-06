//
//  Day6Tests.swift
//  Day6Tests
//

import XCTest

class Day6Tests: XCTestCase {
    let day = Day6()
    let input = "3,4,3,1,2"

    func testPart1() throws {
        let result = day.part1(input)
        XCTAssertEqual(result as? Int, 5934)
    }

    func testPart2() throws {
        let result = day.part2(input)
        XCTAssertEqual(result as? Int, 26984457539)
    }

}
