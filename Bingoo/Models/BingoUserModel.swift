//
//  BingoUserModel.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 07/05/24.
//

import Foundation

struct BingoUserModel: Identifiable, Codable {
    var id: String
    var userName: String
    
    init(id: String, userName: String) {
        self.id = id
        self.userName = userName
    }
}
