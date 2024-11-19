//
//  BingoUserProfile.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 19/05/24.
//

/// This struct is primarily for conforming Codable and transfer data to and from. This is built
/// From the `CDBingoUserModel` in realtime.

import Foundation

struct BingoUserProfile: Codable {
    let id: UUID
    let userName: String
    
    static var current = {
        return BingoUserProfile(
            id: CDBingoUserModel.current?.id ?? UUID(),
            userName: CDBingoUserModel.current?.userName ?? ""
        )
    }()
}
