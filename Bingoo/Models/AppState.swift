//
//  AppState.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 05/05/24.
//

import Foundation

@Observable
class AppState {
  var bingoState = BingoGridModel()
  var comm: BingoCommunication?
  
  func setGameModeComm(_ gameType: BingoGameType) {
    switch gameType {
    case .withDevice:
      comm = LocalCommunication()
    case .withLocalFriend:
      break
    case .online:
      break
    }
  }
}
