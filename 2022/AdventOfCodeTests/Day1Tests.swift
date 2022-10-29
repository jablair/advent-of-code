//
//  Day1Tests.swift
//  Day1Tests
//

import XCTest

class Day1Tests: XCTestCase {
    let day = Day1()

    func testPart1() async throws {
        let result = try await day.part1(
                """
                199
                200
                208
                210
                200
                207
                240
                269
                260
                263
                """
            )
        XCTAssertEqual(result, 7)
    }

    func testPart2() async throws {
        let result = try await day.part2(
                """
                199
                200
                208
                210
                200
                207
                240
                269
                260
                263
                """
        )
        XCTAssertEqual(result, 5)
    }

}
