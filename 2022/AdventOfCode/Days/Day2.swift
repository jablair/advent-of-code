//
//  Day2.swift
//  AdventOfCode
//

import Foundation
import RegularExpressionDecoder

final class Day2: Day {
    
    enum RockPaperScissors {
        case rock
        case paper
        case scissors
        
        var score: Int {
            switch self {
            case .rock:
                return 1
            case .paper:
                return 2
            case .scissors:
                return 3
            }
        }
        
        init?(opponent: String) {
            switch opponent {
            case "A":
                self = .rock
            case "B":
                self = .paper
            case "C":
                self = .scissors
            default:
                return nil
            }
        }
        
        init?(me: String) {
            switch me {
            case "X":
                self = .rock
            case "Y":
                self = .paper
            case "Z":
                self = .scissors
            default:
                return nil
            }
        }
    }
        
    enum Result: String {
        case lose = "X"
        case draw = "Y"
        case win = "Z"
        
        var score: Int {
            switch self {
            case .lose:
                return 0
            case .draw:
                return 3
            case .win:
                return 6
            }
        }
    }

    struct HonestRound: Decodable {
        enum CodingKeys: String, CodingKey {
            case opponent
            case me
        }
        
        let opponent: RockPaperScissors
        let me: RockPaperScissors
        
        var score: Int {
            let result: Result
            switch (me, opponent) {
            case (.rock, .scissors),
                (.scissors, .paper),
                (.paper, .rock):
                result = .win
            case (.rock, .rock),
                (.scissors, .scissors),
                (.paper, .paper):
                result = .draw
            default:
                result = .lose
            }
            
            return result.score + me.score
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            let rawOpponent = try container.decode(String.self, forKey: .opponent)
            let rawMe = try container.decode(String.self, forKey: .me)

            guard let opponent = RockPaperScissors(opponent: rawOpponent) else {
                throw DecodingError.dataCorruptedError(forKey: .opponent, in: container, debugDescription: "Unexpected opponent \(rawOpponent)")
            }
            guard let me = RockPaperScissors(me: rawMe) else {
                throw DecodingError.dataCorruptedError(forKey: .me, in: container, debugDescription: "Unexpected me \(rawMe)")
            }
            
            self.opponent = opponent
            self.me = me
        }
    }

    struct RiggedRound: Decodable {
        enum CodingKeys: String, CodingKey {
            case opponent
            case result
        }
        
        let opponent: RockPaperScissors
        let result: Result
        
        var score: Int {
            let myPlay: RockPaperScissors
            switch (result, opponent) {
            case (.win, .scissors),
                (.lose, .paper),
                (.draw, .rock):
                myPlay = .rock
            case (.win, .rock),
                (.lose, .scissors),
                (.draw, .paper):
                myPlay = .paper
            default:
                myPlay = .scissors
            }
            
            return myPlay.score + result.score
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            let rawOpponent = try container.decode(String.self, forKey: .opponent)
            let rawResult = try container.decode(String.self, forKey: .result)

            guard let opponent = RockPaperScissors(opponent: rawOpponent) else {
                throw DecodingError.dataCorruptedError(forKey: .opponent, in: container, debugDescription: "Unexpected opponent \(rawOpponent)")
            }
            guard let result = Result(rawValue: rawResult) else {
                throw DecodingError.dataCorruptedError(forKey: .result, in: container, debugDescription: "Unexpected result \(rawResult)")
            }
            
            self.opponent = opponent
            self.result = result
        }
    }
    
    func part1(_ input: String) async throws -> Int {
        let pattern: RegularExpressionPattern<HonestRound, HonestRound.CodingKeys> = #"""
            \b
            (?<\#(.opponent)>[ABC])\s
            (?<\#(.me)>[XYZ])
            \b
        """#

        let games: [HonestRound]
        let decoder = try RegularExpressionDecoder<HonestRound>(pattern: pattern, options: .allowCommentsAndWhitespace)
        games = try decoder.decode([HonestRound].self, from: input)

        return games.map(\.score).sum()
    }

    func part2(_ input: String) async throws -> Int {
        let pattern: RegularExpressionPattern<RiggedRound, RiggedRound.CodingKeys> = #"""
            \b
            (?<\#(.opponent)>[ABC])\s
            (?<\#(.result)>[XYZ])
            \b
        """#

        let games: [RiggedRound]
        let decoder = try RegularExpressionDecoder<RiggedRound>(pattern: pattern, options: .allowCommentsAndWhitespace)
        games = try decoder.decode([RiggedRound].self, from: input)

        return games.map(\.score).sum()
    }
}
