//
//  GridTileModel.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 28/04/24.
//

import Foundation
import SwiftUI

public struct GridTileModel: Identifiable, Codable {
    public var id = UUID()
    public let number: Int
    public var index: Int
    public var isSelected: Bool
    
    var row: Int {
        return index / 5
    }
    
    var column: Int {
        return index % 5
    }
    
    init(number: Int, index: Int, isSelected: Bool) {
        self.number = number
        self.index = index
        self.isSelected = isSelected
    }
}
