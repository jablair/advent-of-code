//
//  Day15Tests.swift
//  Day15Tests
//

import XCTest

class Day15Tests: XCTestCase {
    let day = Day15()
    let input = """
    1163751742
    1381373672
    2136511328
    3694931569
    7463417111
    1319128137
    1359912421
    3125421639
    1293138521
    2311944581
    """

    func testPart1() throws {
        let result = try XCTUnwrap(day.part1(input) as? Int32)
        XCTAssertEqual(result, 40)
    }

    func testPart2() throws {
        let result = try XCTUnwrap(day.part2(input) as? Int32)
        XCTAssertEqual(result, 315)
    }

}
