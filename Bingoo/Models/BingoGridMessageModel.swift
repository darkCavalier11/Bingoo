//
//  BingoManagerModel.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 07/05/24.
//

import Foundation

public struct BingoGridMessageModel: Codable {
    var lastSelectedNumber: Int
    var gameState: BingoGameState
    
    init(lastSelectedNumber: Int, gameState: BingoGameState) {
        self.lastSelectedNumber = lastSelectedNumber
        self.gameState = gameState
    }
}

public enum BingoGameState: Codable {
    case waitingForPlayersToJoin(currentPlayersOnLobby: [BingoUserModel])
    case running
    case failed(reason: String)
    case completed(winnerUser: BingoUserModel)
}

public enum BingoGameType: String, CaseIterable, Codable {
    case withDevice = "With Device"
    case withLocalFriend = "With Local Friends"
    case online = "Online"
}
