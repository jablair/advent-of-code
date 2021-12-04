//
//  Day2Tests.swift
//  Day2Tests
//

import XCTest

class Day2Tests: XCTestCase {
    let day = Day2()

    func testPart1() throws {
        let directions = """
            forward 5
            down 5
            forward 8
            up 3
            down 8
            forward 2
            """
        let output = try day.part1(directions)
        XCTAssertEqual(output as? Int, 150)
    }

    func testPart2() throws {
        let directions = """
            forward 5
            down 5
            forward 8
            up 3
            down 8
            forward 2
            """
        let output = try day.part2(directions)
        XCTAssertEqual(output as? Int, 900)
    }

}
