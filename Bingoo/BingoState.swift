//
//  BingoState.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 28/04/24.
//

import Foundation

@Observable
public class BingoState {
    public init() {}
    
    private var _gridElements: [GridTileModel] = []
    
    public var gridElements: [GridTileModel] {
        _gridElements
    }
    
    public var completedGridGroups: [CompletedGridType] = []
    
    public var totalCompletedTileGroups: Int {
        completedGridGroups.count
    }
    
    public enum CompletedGridType: Equatable {
        public enum DiagonalDirection: String, Equatable {
            case topLeftToBottomRight
            case bottomLeftToTopRight
        }
        case row(Int)
        case column(Int)
        case diagonal(DiagonalDirection)
    }
    
    public func setSelectedFor(index: Int) {
        _gridElements[index].isSelected = true
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
            if count == 5 && !completedGridGroups.contains(where: { ele in
                return ele == .row(i)
            }) {
                completedGridGroups.append(.row(i))
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
            if count == 5 && !completedGridGroups.contains(where: { ele in
                return ele == .column(j)
            }) {
                completedGridGroups.append(.column(j))
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
        
        if count == 5 && !completedGridGroups.contains(where: { ele in
            return ele == .diagonal(.topLeftToBottomRight)
        }) {
            completedGridGroups.append(.diagonal(.topLeftToBottomRight))
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
        
        if count == 5 && !completedGridGroups.contains(where: { ele in
            return ele == .diagonal(.bottomLeftToTopRight)
        }) {
            completedGridGroups.append(.diagonal(.bottomLeftToTopRight))
        }
    }
    
    public func generateRandomGridTileElements() {
        _gridElements = []
        var unusedNumbers: [Int] = []
        for i in 0..<25 {
            unusedNumbers.append(i + 1)
        }
        
        for i in 0..<25 {
            let randomNumber = unusedNumbers.randomElement()!
            let index = unusedNumbers.firstIndex(of: randomNumber)!
            unusedNumbers.remove(at: index)
            _gridElements.append(GridTileModel(number: randomNumber, position: i, isSelected: false))
        }
    }
}
