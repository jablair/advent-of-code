//
//  Day7Tests.swift
//  Day7Tests
//

import XCTest

class Day7Tests: XCTestCase {
    let day = Day7()
    let input = """
    $ cd /
    $ ls
    dir a
    14848514 b.txt
    8504156 c.dat
    dir d
    $ cd a
    $ ls
    dir e
    29116 f
    2557 g
    62596 h.lst
    $ cd e
    $ ls
    584 i
    $ cd ..
    $ cd ..
    $ cd d
    $ ls
    4060174 j
    8033020 d.log
    5626152 d.ext
    7214296 k
    """

    override func setUp() async throws {
        try day.setup(input)
    }
    
    func testPart1() async throws {
        let result = try await day.part1(input)
        XCTAssertEqual(result, 95437)
    }

    func testPart2() async throws {
        let result = try await day.part2(input)
        XCTAssertEqual(result, 24933642)
    }

}
