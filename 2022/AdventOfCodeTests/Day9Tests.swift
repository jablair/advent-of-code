//
//  Day9Tests.swift
//  Day9Tests
//

import XCTest

class Day9Tests: XCTestCase {
    let day = Day9()
    let input = """
    R 4
    U 4
    L 3
    D 1
    R 4
    D 1
    L 5
    R 2
    """

    override func setUp() async throws {
        try day.setup(input)
    }
    
    func testPart1() async throws {
        let result = try await day.part1(input)
        XCTAssertEqual(result, 13)
    }

    func testPart2() async throws {
        let result = try await day.part2(input)
        XCTAssertEqual(result, 1)
    }
    
    func test2Larger() async throws {
        let input2 = """
        R 5
        U 8
        L 8
        D 3
        R 17
        D 10
        L 25
        U 20
        """
        
        try day.setup(input2)
        let result = try await day.part2(input2)
        XCTAssertEqual(result, 36)

    }

}
