//
//  Day2Tests.swift
//  Day2Tests
//

import XCTest

class Day2Tests: XCTestCase {
    let day = Day2()
    let input = """
                A Y
                B X
                C Z
                """

    func testPart1() async throws {
        let result = try await day.part1(input)
        XCTAssertEqual(result, 15)
    }

    func testPart2() async throws {
        let result = try await day.part2(input)
        XCTAssertEqual(result, 12)
    }

}
