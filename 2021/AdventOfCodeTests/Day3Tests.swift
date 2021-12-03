//
//  Day3Tests.swift
//  Day3Tests
//

import XCTest

class Day3Tests: XCTestCase {
    let day = Day3()

    func testPart1() throws {
        let input = """
        00100
        11110
        10110
        10111
        10101
        01111
        00111
        11100
        10000
        11001
        00010
        01010
        """
        let result = day.part1(input)
        XCTAssertEqual(result as? Int, 198)
    }

    func testPart2() throws {
        let input = """
        00100
        11110
        10110
        10111
        10101
        01111
        00111
        11100
        10000
        11001
        00010
        01010
        """
        let result = day.part2(input)
        XCTAssertEqual(result as? Int, 230)

    }

}
