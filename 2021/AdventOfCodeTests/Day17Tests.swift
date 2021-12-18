//
//  Day17Tests.swift
//  Day17Tests
//

import XCTest

class Day17Tests: XCTestCase {
    let day = Day17()
    let input = "target area: x=20..30, y=-10..-5"

    override func setUpWithError() throws {
        try day.setup(input)
    }
    
    func testPart1() throws {
        let result = try XCTUnwrap(try day.part1(input) as? Int)
        XCTAssertEqual(result, 45)
        
    }

    func testPart2() throws {
        let result = try XCTUnwrap(try day.part2(input) as? Int)
        XCTAssertEqual(result, 112)
    }

}
