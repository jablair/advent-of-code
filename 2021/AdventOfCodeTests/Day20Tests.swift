//
//  Day20Tests.swift
//  Day20Tests
//

import XCTest

class Day20Tests: XCTestCase {
    let day = Day20()
    let input = """
    ..#.#..#####.#.#.#.###.##.....###.##.#..###.####..#####..#....#..#..##..###..######.###...####..#..#####..##..#.#####...##.#.#..#.##..#.#......#.###.######.###.####...#.##.##..#..#..#####.....#.#....###..#.##......#.....#..#..#..##..#...##.######.####.####.#.#...#.......#..#.#.#...####.##.#......#..#...##.#.##..#...##.#.##..###.#......#.#.......#.#.#.####.###.##...#.....####.#..#..#.##.#....##..#.####....##...##..#...#......#.#.......#.......##..####..#...#.#.#...##..#.#..###..#####........#..####......#..#

    #..#.
    #....
    ##..#
    ..#..
    ..###
    """
    
    override func setUpWithError() throws {
        try day.setup(input)
    }

    func testPart1() throws {
        let result = try XCTUnwrap(day.part1(input) as? Int)
        XCTAssertEqual(result, 35)
    }

    func testPart2() throws {
        let result = try XCTUnwrap(day.part2(input) as? Int)
        XCTAssertEqual(result, 3351)
    }

}
