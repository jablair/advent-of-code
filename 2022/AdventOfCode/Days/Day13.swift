//
//  Day13.swift
//  AdventOfCode
//

import Foundation
import Parsing

final class Day13: Day {
    
    enum MessageContent: Equatable {
        case integer(Int)
        indirect case list([MessageContent])
    }
    
    private func parse(list: inout ArraySlice<Character>) -> [MessageContent] {
        var content: [MessageContent] = []
        
        var currentIntString = ""
        
    listLoop:
        while let first = list.first {
            list = list.dropFirst()
            switch first {
            case _ where first.isNumber:
                currentIntString.append(first)
            case "[":
                if !currentIntString.isEmpty, let int = Int(currentIntString) {
                    content.append(.integer(int))
                    currentIntString = ""
                }
                content.append(.list(parse(list: &list)))
                
            case "]":
                if !currentIntString.isEmpty, let int = Int(currentIntString) {
                    content.append(.integer(int))
                    currentIntString = ""
                }
                break listLoop
            default:
                if !currentIntString.isEmpty, let int = Int(currentIntString) {
                    content.append(.integer(int))
                    currentIntString = ""
                }
            }
        }

        return content
    }
    
    func validate(list left: [Day13.MessageContent], right: [Day13.MessageContent]) -> ComparisonResult {
        for idx in 0..<min(left.count, right.count) {
            let leftItem = left[idx]
            let rightItem = right[idx]
            
            switch (leftItem, rightItem) {
            case let (.integer(leftInt), .integer(rightInt)):
                if leftInt < rightInt {
                    return .orderedDescending
                } else if leftInt > rightInt {
                    return .orderedAscending
                }
            case let (.list(leftList), .list(rightList)):
                let listOrder = validate(list: leftList, right: rightList)
                if listOrder != .orderedSame {
                    return listOrder
                }
            case let (.integer(leftInt), .list(rightList)):
                let leftList = [MessageContent.integer(leftInt)]
                let listOrder = validate(list: leftList, right: rightList)
                if listOrder != .orderedSame {
                    return listOrder
                }
            case let (.list(leftList), .integer(rightInt)):
                let rightList = [MessageContent.integer(rightInt)]
                let listOrder = validate(list: leftList, right: rightList)
                if listOrder != .orderedSame {
                    return listOrder
                }
            }
        }
        
        if left.count > right.count {
            return .orderedAscending
        } else if left.count < right.count {
            return .orderedDescending
        }
        
        return .orderedSame
    }
    
    func part1(_ input: String) async throws -> Int {
        let validPairs = input
            .lines
            .split(whereSeparator: \.isEmpty)
            .map {
                var content1 = Array($0.first!).dropFirst()
                var content2 = Array($0.last!).dropFirst()
                let m1 = parse(list: &content1)
                let m2 = parse(list: &content2)
                return (m1, m2)
            }.enumerated()
            .filter { messageInfo in
                let id = messageInfo.0 + 1
                let messages = messageInfo.1
                return validate(list: messages.0, right: messages.1) == .orderedDescending
            }
        
        return validPairs.map { $0.0 + 1 }.sum()
    }

    func part2(_ input: String) async throws -> Int {
        var messages = input
            .lines
            .filter { !$0.isEmpty }
            .map {
                var content = Array($0).dropFirst()
                return parse(list: &content)
            }

        let divider1: [MessageContent] = [.list([.integer(2)])]
        let divider2: [MessageContent] = [.list([.integer(6)])]
        
        messages.append(divider1)
        messages.append(divider2)
        
        messages = messages.sorted { left, right in
            validate(list: left, right: right) == .orderedDescending
        }
        
        let divider1Idx = messages.firstIndex(of: divider1)! + 1
        let divider2Idx = messages.firstIndex(of: divider2)! + 1
        
        return divider1Idx * divider2Idx
    }
}
