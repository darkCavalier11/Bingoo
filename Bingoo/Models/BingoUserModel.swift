//
//  BingoUserModel.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 07/05/24.
//

import Foundation

struct BingoUserModel: Identifiable, Codable {
    var id: UUID
    var userName: String
    
    init(id: UUID, userName: String) {
        self.id = id
        self.userName = userName
    }
}
