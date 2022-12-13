//
//  Day12.swift
//  AdventOfCode
//

import Foundation
import Algorithms
import GameKit

final class Day12: Day {
    var elevations: GKGridGraph<HillNode>!
    var startPoint: vector_int2!
    var endPoint: vector_int2!
    
    
    func setup(_ input: String) throws {
        let rawElevations = input
            .components(separatedBy: "\n")
            .map { $0.map { $0 } }
        
        let width = Int32(rawElevations[0].count)
        let height = Int32(rawElevations.count)
        elevations = GKGridGraph<HillNode>(
            fromGridStartingAt: vector_int2(0, 0),
            width: width,
            height: height,
            diagonalsAllowed: false,
            nodeClass: HillNode.self)
        
        for (x, y) in product(0..<width, 0..<height) {
            let raw = rawElevations[Int(y)][Int(x)]
            let rawInt: UInt8
            switch raw {
            case "S":
                startPoint = vector_int2(x: x, y: y)
                rawInt = 0
            case "E":
                endPoint = vector_int2(x: x, y: y)
                rawInt = 25
            default:
                rawInt = raw.asciiValue! - Character("a").asciiValue!
            }

            elevations.node(atGridPosition: vector_int2(x, y))?.height = rawInt
        }
        
        for (x, y) in product(0..<width, 0..<height) {
            let pos = vector_int2(x: x, y: y)
            guard let node = elevations.node(atGridPosition: pos) else {
                continue
            }
            
            let disonnections = pos.neighbors.compactMap { neighborPos -> HillNode? in
                guard let neighbor = elevations.node(atGridPosition: neighborPos),
                      neighbor.height > node.height + 1 else {
                    return nil
                }
                
                return neighbor
            }
            node.removeConnections(to: disonnections, bidirectional: false)
        }
    }
    
    func part1(_ input: String) async throws -> Int {
        guard let startNode = elevations.node(atGridPosition: startPoint),
              let endNode = elevations.node(atGridPosition: endPoint) else {
            return 0
        }
                
        return elevations.findPath(from: startNode, to: endNode).count - 1
    }

    func part2(_ input: String) async throws -> Int {
        guard let endNode = elevations.node(atGridPosition: endPoint) else {
            return 0
        }

        var startPoints: [HillNode] = []
        for (x, y) in product(0..<elevations.gridWidth, 0..<elevations.gridHeight) {
            let pos = vector_int2(x: Int32(x), y: Int32(y))
            
            guard let candidate = elevations.node(atGridPosition: pos),
                  candidate.height == 0 else {
                continue
            }
            
            startPoints.append(candidate)
        }
        
        let paths = startPoints.map { elevations.findPath(from: $0, to: endNode).count - 1 }.filter { $0 != -1 }
                                                  
        return paths.min()!
    }
    
    class HillNode: GKGridGraphNode {
        var height: UInt8 = 0
    }
}

private extension vector_int2 {
    var neighbors: [vector_int2] {
        [
            vector_int2(x: x - 1, y: y),
            vector_int2(x: x + 1, y: y),
            vector_int2(x: x, y: y - 1),
            vector_int2(x: x, y: y + 1)
        ]
    }
}
