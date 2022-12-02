//
//  Day1Tests.swift
//  Day1Tests
//

import XCTest
@testable import AdventOfCode

class Day1Tests: XCTestCase {
    let day = Day1()

    override func setUp() async throws {
        try day.setup("""
                1000
                2000
                3000

                4000

                5000
                6000

                7000
                8000
                9000

                10000
                """
        )
    }
    
    func testPart1() async throws {
        let result = try await day.part1(
                """
                1000
                2000
                3000

                4000

                5000
                6000

                7000
                8000
                9000

                10000
                """
            )
        XCTAssertEqual(result, 24000)
    }

    func testPart2() async throws {
        let result = try await day.part2(
                """
                1000
                2000
                3000

                4000

                5000
                6000

                7000
                8000
                9000

                10000
                """
        )
        XCTAssertEqual(result, 45000)
    }

}
