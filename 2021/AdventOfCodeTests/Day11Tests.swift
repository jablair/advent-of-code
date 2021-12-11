//
//  Day11Tests.swift
//  Day11Tests
//

import XCTest

class Day11Tests: XCTestCase {
    let day = Day11()
    let input = """
    5483143223
    2745854711
    5264556173
    6141336146
    6357385478
    4167524645
    2176841721
    6882881134
    4846848554
    5283751526
    """

    func testPart1() throws {
        let result = day.part1(input)
        XCTAssertEqual(result as? Int, 1656)
    }

    func testPart2() throws {
        let result = day.part2(input)
        XCTAssertEqual(result as? Int, 195)
    }

}
