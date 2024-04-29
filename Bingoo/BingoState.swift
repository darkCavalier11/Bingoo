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
    var completedGrids: [CompletedGridType] = []
    
    var totalCompletedTileGroups: Int {
        completedGrids.count
    }
    
    enum CompletedGridType {
        enum DiagonalDirection: String {
            case topLeftToBottomRight
            case bottomLeftToTopRight
        }
        case row(Int)
        case column(Int)
        case diagonal(DiagonalDirection)
    }
    
    public func setSelectedFor(index: Int) {
        gridElements[index].isSelected = true
        checkAndAddCompletedTileGroups()
    }
    
    private func checkAndAddCompletedTileGroups() {
        /// check if any row has been completely filled
        for i in 0..<5 {
            var count = 0
            for j in 0..<5 {
                if gridElements[i*5 + j].isSelected {
                    count += 1
                }
            }
            if count == 5 {
                completedGrids.append(.row(i))
            }
        }
        
        /// Check any column is completely filled
        for j in 0..<5 {
            var count = 0
            for i in 0..<5 {
                if gridElements[i * 5 + j].isSelected {
                    count += 1
                }
            }
            if count == 5 {
                completedGrids.append(.column(j))
            }
        }
        
        /// check if any TL - BR diagonal is filled
        var i = 0, j = 0, count = 0
        while i < 5 && j < 5 {
            if gridElements[i * 5 + j].isSelected {
                count += 1
            }
            i += 1
            j += 1
        }
        
        if count == 5 {
            completedGrids.append(.diagonal(.topLeftToBottomRight))
        }
        
        /// check if any TL - BR diagonal is filled
        i = 4
        j = 0
        count = 0
        while i >= 0 && j < 5 {
            if gridElements[i * 5 + j].isSelected {
                count += 1
            }
            i -= 1
            j += 1
        }
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
