//
//  Day9Tests.swift
//  Day9Tests
//

import XCTest

class Day9Tests: XCTestCase {
    let day = Day9()
    let input = """
    2199943210
    3987894921
    9856789892
    8767896789
    9899965678
    """

    func testPart1() throws {
        let result = day.part1(input)
        XCTAssertEqual(result as? Int, 15)
    }

    func testPart2() throws {
        let result = day.part2(input)
        XCTAssertEqual(result as? Int, 1134)
    }

}
