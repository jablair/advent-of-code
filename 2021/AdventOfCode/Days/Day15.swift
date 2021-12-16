//
//  Day15.swift
//  AdventOfCode
//

import Foundation
import Algorithms
import GameKit

final class Day15: Day {
    
    func part1(_ input: String) -> CustomStringConvertible {
        let cavern = input
            .components(separatedBy: "\n")
            .compactMap {
                $0.compactMap { Int32(String($0)) }
            }
        
        let width = Int32(cavern[0].count)
        let height = Int32(cavern.count)
        let graph = GKGridGraph<RiskNode>(
            fromGridStartingAt: vector_int2(0, 0),
            width: width,
            height: height,
            diagonalsAllowed: false,
            nodeClass: RiskNode.self)
        
        for (x, y) in product(0..<width, 0..<height) {
            graph.node(atGridPosition: vector_int2(x, y))?.risk = cavern[Int(y)][Int(x)]
        }
        
        guard let startNode = graph.node(atGridPosition: vector_int2(0, 0)),
              let endNode = graph.node(atGridPosition: vector_int2(width - 1, height - 1)),
              let solution = graph.findPath(from: startNode, to: endNode) as? [RiskNode] else {
                  return 0
              }
        
        return solution
            .map(\.risk)
            .reduce(0, +) - startNode.risk
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let multipler: Int32 = 5
        let cavern = input
            .components(separatedBy: "\n")
            .compactMap {
                $0.compactMap { Int32(String($0)) }
            }
        
        let width = Int32(cavern[0].count) * multipler
        let height = Int32(cavern.count) * multipler
        let graph = GKGridGraph<RiskNode>(
            fromGridStartingAt: vector_int2(0, 0),
            width: width,
            height: height,
            diagonalsAllowed: false,
            nodeClass: RiskNode.self)
        
        let sourceWidth = Int32(cavern[0].count)
        let sourceHeight = Int32(cavern.count)
        for (x, y) in product(0..<sourceWidth, 0..<sourceHeight) {
            for (right, down) in product(0..<multipler, 0..<multipler) {
                let source = cavern[Int(y)][Int(x)]
                let score = source + right + down
                
                let targetX = x + sourceWidth * right
                let targetY = y + sourceHeight * down
                let node = graph.node(atGridPosition: vector_int2(targetX, targetY))
                node?.risk = score <= 9 ? score : score % 9
            }
        }
        
        guard let startNode = graph.node(atGridPosition: vector_int2(0, 0)),
              let endNode = graph.node(atGridPosition: vector_int2(width - 1, height - 1)),
              let solution = graph.findPath(from: startNode, to: endNode) as? [RiskNode] else {
                  return 0
              }
        
        return solution
            .map(\.risk)
            .reduce(0, +) - startNode.risk
    }
}

class RiskNode: GKGridGraphNode {
    var risk: Int32 = 0
    
    override func cost(to node: GKGraphNode) -> Float {
        Float(risk)
    }
}
