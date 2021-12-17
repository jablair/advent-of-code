//
//  Day16Tests.swift
//  Day16Tests
//

import XCTest

class Day16Tests: XCTestCase {
    let day = Day16()

    func testPart1() throws {
        var result = try XCTUnwrap(day.part1("D2FE28") as? Int)
        XCTAssertEqual(result, 6)
        
        result = try XCTUnwrap(day.part1("38006F45291200") as? Int)
        XCTAssertEqual(result, 9)
        
        result = try XCTUnwrap(day.part1("EE00D40C823060") as? Int)
        XCTAssertEqual(result, 14)

        result = try XCTUnwrap(day.part1("8A004A801A8002F478") as? Int)
        XCTAssertEqual(result, 16)

        result = try XCTUnwrap(day.part1("620080001611562C8802118E34") as? Int)
        XCTAssertEqual(result, 12)

        result = try XCTUnwrap(day.part1("C0015000016115A2E0802F182340") as? Int)
        XCTAssertEqual(result, 23)

        result = try XCTUnwrap(day.part1("A0016C880162017C3686B18A3D4780") as? Int)
        XCTAssertEqual(result, 31)

    }

    func testPart2() throws {
        var result = try XCTUnwrap(day.part2("C200B40A82") as? Int)
        XCTAssertEqual(result, 3)
        
        result = try XCTUnwrap(day.part2("04005AC33890") as? Int)
        XCTAssertEqual(result, 54)
        
        result = try XCTUnwrap(day.part2("880086C3E88112") as? Int)
        XCTAssertEqual(result, 7)
        
        result = try XCTUnwrap(day.part2("CE00C43D881120") as? Int)
        XCTAssertEqual(result, 9)
        
        result = try XCTUnwrap(day.part2("D8005AC2A8F0") as? Int)
        XCTAssertEqual(result, 1)
        
        result = try XCTUnwrap(day.part2("F600BC2D8F") as? Int)
        XCTAssertEqual(result, 0)
        
        result = try XCTUnwrap(day.part2("9C005AC2F8F0") as? Int)
        XCTAssertEqual(result, 0)
        
        result = try XCTUnwrap(day.part2("9C0141080250320F1802104A08") as? Int)
        XCTAssertEqual(result, 1)
        
    }

}
