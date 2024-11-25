//
//  BingoState.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 28/04/24.
//

import Foundation
import SwiftUI

@Observable
public class BingoGridModel: Codable {
    public init() {
      generateRandomGridTileElements()
    }
    
    private(set) var gridElements: [GridTileModel] = []

    
    var crossLineFrameWidths = Array(repeating: 0.0, count: 12)
    var crossLineFrameHeights = Array(repeating: 0.0, count: 12)
  
  enum CodingKeys: String, CodingKey {
    case gridElements
    case crossLineFrameWidths
    case crossLineFrameHeights
  }
  
  public required init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    gridElements = try container.decode([GridTileModel].self, forKey: .gridElements)
    crossLineFrameWidths = try container.decode([Double].self, forKey: .crossLineFrameWidths)
    crossLineFrameHeights = try container.decode([Double].self, forKey: .crossLineFrameHeights)
  }
  
  public func encode(to encoder: any Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(gridElements, forKey: .gridElements)
    try container.encode(crossLineFrameWidths, forKey: .crossLineFrameWidths)
    try container.encode(crossLineFrameHeights, forKey: .crossLineFrameHeights)
  }
  
  public var completedGridGroups: [CompletedGridType] = [] {
    didSet {
      if completedGridGroups.isEmpty {
        return
      }
      
      for item in completedGridGroups {
        switch item {
        case .row(let rowIndex):
          markRow(rowIndex)
        case .column(let colIndex):
          markColumn(colIndex)
        case .diagonal(let diagonalType):
          markDiagonal(diagonalType)
        }
      }
    }
  }
    
    public var totalCompletedTileGroups: Int {
        completedGridGroups.count
    }
    
    public enum CompletedGridType: Equatable, Codable {
        public enum DiagonalDirection: String, Equatable, Codable {
            case topLeftToBottomRight
            case bottomLeftToTopRight
        }
        case row(Int)
        case column(Int)
        case diagonal(DiagonalDirection)
    }
    
    public func setSelectedFor(num: Int) {
        if totalCompletedTileGroups == 5 {
            return
        }
      guard let numberIndex = gridElements.firstIndex(where: { $0.number == num }) else {
        return
      }
      gridElements[numberIndex].isSelected = true
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
        reset()
        var unusedNumbers: [Int] = []
        for i in 0..<25 {
            unusedNumbers.append(i + 1)
        }
        
        for i in 0..<25 {
            let randomNumber = unusedNumbers.randomElement()!
            let index = unusedNumbers.firstIndex(of: randomNumber)!
            unusedNumbers.remove(at: index)
            gridElements.append(GridTileModel(number: randomNumber, index: i, isSelected: false))
        }
    }
    
    private func reset() {
        gridElements = []
        completedGridGroups = []
    }
    
    func markRow(_ rowIndex: Int) {
        crossLineFrameHeights[rowIndex] = 4
        withAnimation {
            crossLineFrameWidths[rowIndex] = GridTile.itemSize.width * 5
        }
    }
    
    func markColumn(_ colIndex: Int) {
        crossLineFrameHeights[colIndex + 5] = 4
        withAnimation {
            crossLineFrameWidths[colIndex + 5] = GridTile.itemSize.width * 5
        }
        
    }
    
    func markDiagonal(_ diagonalType: BingoGridModel.CompletedGridType.DiagonalDirection) {
        if diagonalType == .topLeftToBottomRight {
            crossLineFrameHeights[10] = 4
            withAnimation {
                crossLineFrameWidths[10] = GridTile.itemSize.width * 7
            }
            
        } else {
            crossLineFrameHeights[11] = 4
            withAnimation {
                crossLineFrameWidths[11] = GridTile.itemSize.width * 7
            }
        }
    }
}
