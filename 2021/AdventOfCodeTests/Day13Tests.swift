//
//  Day13Tests.swift
//  Day13Tests
//

import XCTest

class Day13Tests: XCTestCase {
    let day = Day13()
    let input = """
    6,10
    0,14
    9,10
    0,3
    10,4
    4,11
    6,0
    6,12
    4,1
    0,13
    10,12
    3,4
    3,0
    8,4
    1,10
    2,14
    8,10
    9,0

    fold along y=7
    fold along x=5
    """

    func testPart1() throws {
        let result = try day.part1(input)
        XCTAssertEqual(result as? Int, 17)
    }
    
    func testEvenRowPart1() throws {
        let input = """
        0,0
        2,0
        4,0
        1,1
        3,1
        5,1
        0,2
        2,2
        4,2
        1,4
        3,4
        5,4
        0,5
        2,5
        4,5

        fold along y=3
        """
        let result = try day.part1(input)
        XCTAssertEqual(result as? Int, 15)
    }
    
    func testEventColPart1() throws {
        let input = """
        0,0
        2,0
        5,0
        1,1
        4,1
        0,2
        2,2
        5,2
        1,3
        4,3
        0,4
        2,4
        5,4
        1,5
        4,5

        fold along x=3
        """
        let result = try day.part1(input)
        XCTAssertEqual(result as? Int, 15)
    }

    func testPart2() throws {
        let result = try XCTUnwrap(try day.part2(input) as? Matrix<Bool>)
        var expected = Matrix<Bool>(repeating: false, rows: 7, columns: 5)
        for c in 0..<result.colCount {
            expected[0, c] = true
            expected[4, c] = true
        }
        
        for r in 1..<4 {
            expected[r, 0] = true
            expected[r, 4] = true
        }
        
        XCTAssertEqual(result, expected)
    }

}
