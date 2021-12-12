//
//  Day12Tests.swift
//  Day12Tests
//

import XCTest

class Day12Tests: XCTestCase {
    let day = Day12()
    var input = """
    start-A
    start-b
    A-c
    A-b
    b-d
    A-end
    b-end
    """

    func testPart1() throws {
        let result = day.part1(input)
        XCTAssertEqual(result as? Int, 10)
    }
    
    func testPart1Medium() throws {
        let input = """
        dc-end
        HN-start
        start-kj
        dc-start
        dc-HN
        LN-dc
        HN-end
        kj-sa
        kj-HN
        kj-dc
        """
        let result = day.part1(input)
        XCTAssertEqual(result as? Int, 19)
    }
    
    func testPart1Large() throws {
        let input = """
        fs-end
        he-DX
        fs-he
        start-DX
        pj-DX
        end-zg
        zg-sl
        zg-pj
        pj-he
        RW-he
        fs-DX
        pj-RW
        zg-RW
        start-pj
        he-WI
        zg-he
        pj-fs
        start-RW
        """
        let result = day.part1(input)
        XCTAssertEqual(result as? Int, 226)
    }

    func testPart2() throws {
        let result = day.part2(input)
        XCTAssertEqual(result as? Int, 0)
    }

}
