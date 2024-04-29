//
//  BingoState.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 28/04/24.
//

import Foundation

@Observable
class BingoState {
    private(set) var gridElements: [GridTileModel] = []
    
    public func setSelectedFor(index: Int) {
        gridElements[index].isSelected = true
    }
    
    public func generateRandomGridTileElements() {
        gridElements = []
        var unusedNumbers: [Int] = []
        for i in 0..<25 {
            unusedNumbers.append(i + 1)
        }
        
        for i in 0..<25 {
            let randomNumber = unusedNumbers.randomElement()!
            let index = unusedNumbers.firstIndex(of: randomNumber)!
            unusedNumbers.remove(at: index)
            gridElements.append(GridTileModel(number: randomNumber, position: i, isSelected: false))
        }
    }
}
