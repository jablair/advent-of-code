//
//  Day4.swift
//  AdventOfCode
//

import Foundation

final class Day4: Day {
    
    enum Error: Swift.Error {
        case noSolvableBoard
    }
    struct BoardPlayInfo: Hashable {
        let location: Point
        let value: Int
        
        func isOnRow(_ row: Int) -> Bool {
            location.row == row
        }
        
        func isOnColumn(_ col: Int) -> Bool {
            location.col == col
        }
    }
  
    let bingoSize = 5
    
    func part1(_ input: String) throws -> CustomStringConvertible {
        let data = input.split(separator: "\n", maxSplits: 1)
        let plays = data[0]
            .components(separatedBy: ",")
            .compactMap { Int($0) }
       
        let boards = generateBoards(from: data[1])
        
        var boardPlays = Array(repeating: Set<BoardPlayInfo>(), count: boards.count)
        
        var winningBoard = -1
        var lastPlay = -1

    Game:
        for play in plays {
            lastPlay = play
            
            for (idx, board) in boards.enumerated() {
                guard let pos = board.firstIndex(of: play) else {
                    continue
                }
                let location = Point(row: pos / bingoSize, col: pos % bingoSize)
                boardPlays[idx].insert(BoardPlayInfo(location: location, value: play))

                let rowCount = boardPlays[idx].count(where: { $0.isOnRow(location.row) })
                let colCount = boardPlays[idx].count(where: { $0.isOnColumn(location.col)})
                if rowCount == bingoSize || colCount == bingoSize {
                    winningBoard = idx
                    break Game
                }
            }
        }
        
        guard winningBoard >= 0 else {
            throw Error.noSolvableBoard
        }
        
        return boardValue(for: boards[winningBoard], plays: boardPlays[winningBoard]) * lastPlay
    }
    
    func part2(_ input: String) throws -> CustomStringConvertible {
        let data = input.split(separator: "\n", maxSplits: 1)
        let plays = data[0]
            .components(separatedBy: ",")
            .compactMap { Int($0) }
       
        let boards = generateBoards(from: data[1])
        
        var completedBoards = IndexSet()
        var boardPlays = Array(repeating: Set<BoardPlayInfo>(), count: boards.count)
        
        var losingBoard = -1
        var lastPlay = -1

    Game:
        for play in plays {
            lastPlay = play
            for (idx, board) in boards.enumerated() {
                guard !completedBoards.contains(idx),
                      let pos = board.firstIndex(of: play) else {
                    continue
                }
                let location = Point(row: pos / bingoSize, col: pos % bingoSize)
                boardPlays[idx].insert(BoardPlayInfo(location: location, value: play))

                let rowCount = boardPlays[idx].count(where: { $0.isOnRow(location.row) })
                let colCount = boardPlays[idx].count(where: { $0.isOnColumn(location.col)})
                if rowCount == bingoSize || colCount == bingoSize {
                    completedBoards.insert(idx)
                    
                    if completedBoards.count == boards.count {
                        losingBoard = idx
                        break Game
                    }
                }
            }
        }
        
        guard losingBoard >= 0 else {
            throw Error.noSolvableBoard
        }

        return boardValue(for: boards[losingBoard], plays: boardPlays[losingBoard]) * lastPlay
    }
    
    func generateBoards(from data: String.SubSequence) -> [[Int]] {
        let rawBoards = data
            .components(separatedBy: "\n")
            .filter { !$0.isEmpty }

        var boards: [[Int]] = []
        var currentBoard: [Int] = []
        for (idx, row) in rawBoards.enumerated() {
            if idx % bingoSize == 0, idx > 0 {
                boards.append(currentBoard)
                currentBoard = []
            }
            
            currentBoard += row
                .split(separator: " ")
                .compactMap { Int($0) }
        }
        
        if !currentBoard.isEmpty {
            boards.append(currentBoard)
        }
        
        return boards
    }
    
    func boardValue(for board: [Int], plays: Set<BoardPlayInfo>) -> Int {
        let boardSum = board.reduce(0, +)
        let playedSum: Int = plays.reduce(0) {
            $0 + $1.value
        }
        
        return boardSum - playedSum
    }
}

