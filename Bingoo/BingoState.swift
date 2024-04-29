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
    public func clearGridElements() {
        gridElements.removeAll()
    }
    
    public func appendGridElement(_ element: GridTileModel) {
        gridElements.append(element)
    }
    
    public func setSelectedFor(index: Int) {
        gridElements[index].isSelected = true
    }
}
