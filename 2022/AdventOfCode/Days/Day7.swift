//
//  Day7.swift
//  AdventOfCode
//

import Foundation
import Parsing

final class Day7: Day {
    
    enum Input: Equatable {
        case cd(String)
        case ls
        case directory(String)
        case file(Int, String)
    }
    
    struct Directory {
        let name: String
        let files: [File]
        var directories: [Directory]
        
        var size: Int {
            let fileSize = files.map(\.size).sum()
            let nestedSize = directories.map(\.size).sum()
            
            return fileSize + nestedSize
        }
    }
    
    struct File {
        let name: String
        let size: Int
    }
    
    var fileSystem: Directory!
    
    func setup(_ input: String) throws {
        let cdParser = Parse {
            "$ cd "
            Prefix { $0 != "\n" }
        }.map { Input.cd(String($0)) }

        let lsParser = Parse {
            "$ ls"
        }.map { Input.ls }

        let directoryParser = Parse {
            "dir "
            Prefix { $0 != "\n" }
        }.map { Input.directory(String($0)) }

        let fileParser = Parse {
            Int.parser()
            " "
            Prefix { $0 != "\n" }
        }.map { Input.file($0, String($1)) }

        let inputLineParser = Parse {
            OneOf {
                cdParser
                lsParser
                directoryParser
                fileParser
            }
        }
        let inputParser = Parse {
            Many {
                inputLineParser
            } separator: {
                Whitespace(1, .vertical)
            }
        }

        var instructions = try inputParser.parse(input)[0...]
        fileSystem = parseCD(commands: &instructions)
    }
    
    
    func part1(_ input: String) async throws -> Int {
        return extractDirectories(from: fileSystem)
            .map(\.size)
            .filter { $0 < 100000 }
            .sum()
    }

    func part2(_ input: String) async throws -> Int {
        let diskspace = 70000000
        let requiredSpace = 30000000
        let unusedSpace = diskspace - fileSystem.size
        
        return extractDirectories(from: fileSystem)
            .map(\.size)
            .filter { $0 >= requiredSpace - unusedSpace }
            .min()!
        
    }
    
    func extractDirectories(from directory: Directory) -> [Directory] {
        if directory.directories.isEmpty {
            return [directory]
        }
        
        return directory.directories.map { extractDirectories(from: $0) }.flatMap { $0 } + [directory]
    }

    func parseCD(commands: inout ArraySlice<Input>) -> Directory {
        guard case .cd(let name) = commands.first, name != ".." else {
            preconditionFailure()
        }

        commands.removeFirst()
        return directoryForLS(name: name, commands: &commands)
    }
        
    func directoryForLS(name: String, commands: inout ArraySlice<Input>) -> Directory {
        precondition(commands.first == .ls)
        commands.removeFirst()

        var files: [File] = []
        var directories: [Directory] = []

        while !commands.isEmpty {
            let command = commands.first!
            guard command != .cd("..") else {
                commands.removeFirst()
                break
            }

            switch command {
            case .directory:
                commands.removeFirst()
            case let .file(size, name):
                files.append(File(name: name, size: size))
                commands.removeFirst()
            case .cd:
                directories.append(parseCD(commands: &commands))
            case .ls:
                fatalError()
            }
            
        }

        return Directory(name: name, files: files, directories: directories)
    }
}
