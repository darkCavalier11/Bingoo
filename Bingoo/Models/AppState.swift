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
  
  init(bingoState: BingoGridModel = BingoGridModel(), comm: BingoCommunication) {
    self.bingoState = bingoState
    self.comm = comm
  }
}
