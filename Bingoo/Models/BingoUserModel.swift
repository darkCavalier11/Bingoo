//
//  BingoUserModel.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 07/05/24.
//

import Foundation

public struct BingoUserModel: Identifiable, Codable {
    public var id: UUID
    var userName: String
    
    init(id: UUID, userName: String) {
        self.id = id
        self.userName = userName
    }
}
