//
//  Day20.swift
//  AdventOfCode
//

import Foundation
import Algorithms

final class Day20: Day {
    var algorithm: [Bool] = []
    var image: Matrix<Bool> = Matrix(data: [])
    
    func setup(_ input: String) throws {
        let split = input.components(separatedBy: "\n\n")
        algorithm = split[0].map { $0 == "#" }
        let imageData = split[1]
            .components(separatedBy: "\n")
            .map { imageLine in
                imageLine.map { $0 == "#" }
            }
        image = Matrix(data: imageData)
    }
    
    func decompress(image: Matrix<Bool>, defaultState: Bool) -> Matrix<Bool> {
        var outputImage = Matrix<Bool>(repeating: false,
                                       rows: image.rowCount + 2,
                                       columns: image.colCount + 2)
        
        for (row, col) in product(outputImage.rowIndices, outputImage.colIndices) {
            let inputRow = row - 1
            let inputCol = col - 1
            var sourcePixels: [Bool] = []
            
            sourcePixels.append(image.neighbor(.northeast, of: inputRow, col: inputCol)?.0 ?? defaultState)
            sourcePixels.append(image.neighbor(.north, of: inputRow, col: inputCol)?.0 ?? defaultState)
            sourcePixels.append(image.neighbor(.northwest, of: inputRow, col: inputCol)?.0 ?? defaultState)
            
            sourcePixels.append(image.neighbor(.east, of: inputRow, col: inputCol)?.0 ?? defaultState)
            if image.rowIndices.contains(inputRow), image.colIndices.contains(inputCol) {
                sourcePixels.append(image[inputRow, inputCol])
            } else {
                sourcePixels.append(defaultState)
            }
            sourcePixels.append(image.neighbor(.west, of: inputRow, col: inputCol)?.0 ?? defaultState)
            
            sourcePixels.append(image.neighbor(.southeast, of: inputRow, col: inputCol)?.0 ?? defaultState)
            sourcePixels.append(image.neighbor(.south, of: inputRow, col: inputCol)?.0 ?? defaultState)
            sourcePixels.append(image.neighbor(.southwest, of: inputRow, col: inputCol)?.0 ?? defaultState)
            
            let algoLookup = Int(bits: sourcePixels)
            
            outputImage[row, col] = algorithm[algoLookup]
        }
        
        return outputImage
    }
    
    func part1(_ input: String) -> CustomStringConvertible {
        let pass1 = decompress(image: image, defaultState: false)
        let pass2 = decompress(image: pass1, defaultState: algorithm[0])

        return pass2.count { $0 }
    }

    func part2(_ input: String) -> CustomStringConvertible {
        var defaultState = false
        var image = image
        for _ in 0..<50 {
            image = decompress(image: image, defaultState: defaultState)
            defaultState = defaultState ? algorithm[511] : algorithm[0]
        }
        return image.count { $0 }
    }
}
