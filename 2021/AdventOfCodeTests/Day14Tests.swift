//
//  Day14Tests.swift
//  Day14Tests
//

import XCTest

class Day14Tests: XCTestCase {
    let day = Day14()
    let input = """
    NNCB

    CH -> B
    HH -> N
    CB -> H
    NH -> C
    HB -> C
    HC -> B
    HN -> C
    NN -> C
    BH -> H
    NC -> B
    NB -> B
    BN -> B
    BB -> N
    BC -> B
    CC -> N
    CN -> C
    """

    func testPart1() throws {
        let result = try XCTUnwrap(try day.part1(input) as? Int)
        XCTAssertEqual(result, 1588)
    }

    func testPart2() throws {
        let result = try XCTUnwrap(try day.part2(input) as? Int)
        XCTAssertEqual(result, 2188189693529)
    }

}
