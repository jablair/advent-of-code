//
//  Day7Tests.swift
//  Day7Tests
//

import XCTest

class Day7Tests: XCTestCase {
    let day = Day7()
    let input = "16,1,2,0,4,2,7,1,2,14"

    func testPart1() throws {
        let result = day.part1(input)
        XCTAssertEqual(result as? Int, 37)
    }

    func testPart2() throws {
        let result = day.part2(input)
        XCTAssertEqual(result as? Int, 168)
    }

}
