//
//  LocalCommunication.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 19/11/24.
//

import Foundation
import Combine

class LocalCommunication: BingoCommunication {
  let deviceGridModel = BingoGridModel()
  
  var messageSubject: CurrentValueSubject<BingoMessageModel, Never> {
    .init(.waitingForPlayerToJoin)
  }
  
  func sendEvent(message: BingoMessageModel) {
    
  }
  
  var canSendEvent = true
}