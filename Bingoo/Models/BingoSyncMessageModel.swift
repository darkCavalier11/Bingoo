//
//  BingoManagerModel.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 07/05/24.
//

import Foundation

public enum BingoGameType: String, CaseIterable, Codable {
    case withDevice = "With Device"
    case withLocalFriend = "With Local Friends"
    case online = "Online"
}
