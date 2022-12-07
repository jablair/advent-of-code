//
//  Day3Tests.swift
//  Day3Tests
//

import XCTest

class Day3Tests: XCTestCase {
    let day = Day3()
    let input = """
    vJrwpWtwJgWrhcsFMMfFFhFp
    jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
    PmmdzqPrVvPwwTWBwg
    wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
    ttgJtRGJQctTZtZT
    CrZsJsPPZsGzwwsLwLmpwMDw
    """

    override func setUp() async throws {
        try day.setup(input)
    }

    func testPart1() async throws {
        let result = try await day.part1(input)
        XCTAssertEqual(result, 157)
    }

    func testPart2() async throws {
        let result = try await day.part2(input)
        XCTAssertEqual(result, 70)
    }

}
