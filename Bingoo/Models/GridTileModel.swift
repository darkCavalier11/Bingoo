//
//  GridTileModel.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 28/04/24.
//

import Foundation

struct GridTileModel: Codable {
    let number: Int
    var position: Int
    var row: Int {
        return position / 5
    }
    
    var column: Int {
        return position % 5
    }
    
    init(number: Int, position: Int) {
        self.number = number
        self.position = position
    }
    
    
}
