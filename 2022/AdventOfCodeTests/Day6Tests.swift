//
//  Day6Tests.swift
//  Day6Tests
//

import XCTest

class Day6Tests: XCTestCase {
    let day = Day6()
    let input = "mjqjpqmgbljsphdztnvjfqwrcgsmlb"

    func testPart1() async throws {
        let result = try await day.part1(input)
        XCTAssertEqual(result, 7)
        
        let r2 = try await day.part1("bvwbjplbgvbhsrlpgdmjqwftvncz")
        XCTAssertEqual(r2, 5)

        let r3 = try await day.part1("nppdvjthqldpwncqszvftbrmjlhg")
        XCTAssertEqual(r3, 6)
    }

    func testPart2() async throws {
        let result = try await day.part2(input)
        XCTAssertEqual(result, 19)
    }

}
