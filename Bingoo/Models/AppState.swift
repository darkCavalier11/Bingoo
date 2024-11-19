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
  var comm: BingoCommunication
  
  init(gameType: BingoGameType) {
    switch gameType {
    case .withDevice:
      self.comm = LocalCommunication()
    case .withLocalFriend:
      self.comm = LocalCommunication()
    case .online:
      self.comm = LocalCommunication()
    }
  }
}
