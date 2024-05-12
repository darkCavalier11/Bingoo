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
    public var position: Int
    public var isSelected: Bool
    
    var row: Int {
        return position / 5
    }
    
    var column: Int {
        return position % 5
    }
    
    init(number: Int, position: Int, isSelected: Bool) {
        self.number = number
        self.position = position
        self.isSelected = isSelected
    }
}
