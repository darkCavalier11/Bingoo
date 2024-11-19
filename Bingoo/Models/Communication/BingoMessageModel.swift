//
//  BingoManagerModel.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 07/05/24.
//

import Foundation

enum BingoMessageModel: Codable {
  case waitingForPlayerToJoin
  case started(host: String, joinee: String)
  case receiveUpdateWith(selectedNumber: Int, userProfile: BingoUserProfile)
  case failure(reason: String)
  case playerWon(userProfile: BingoUserProfile, gridElements: [GridTileModel])
}
