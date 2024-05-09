//
//  BingoManagerModel.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 07/05/24.
//

import Foundation

struct BingoManagerModel: Codable {
    var id: UUID
    var userList: [BingoUserModel]
    var currentUserTurnIndex: Int
    var lastSelectedNumber: Int
    var gameState: BingoGameState
    var gameType: BingoGameType
    
    init(id: UUID, userList: [BingoUserModel], currentUserTurnIndex: Int, lastSelectedNumber: Int, gameState: BingoGameState, gameType: BingoGameType) {
        self.id = id
        self.userList = userList
        self.currentUserTurnIndex = currentUserTurnIndex
        self.lastSelectedNumber = lastSelectedNumber
        self.gameState = gameState
        self.gameType = gameType
    }
}

enum BingoGameState: Codable {
    case waitingForPlayersToJoin(currentPlayerOnLobby: Int)
    case running
    case failed(reason: String)
    case completed(winnerUser: BingoUserModel)
}

enum BingoGameType: String, CaseIterable, Codable {
    case withDevice = "With Device"
    case withLocalFriend = "With Local Friends"
    case online = "Online"
}
