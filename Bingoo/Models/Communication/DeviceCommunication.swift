//
//  LocalCommunication.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 19/11/24.
//

import Foundation
import Combine

class DeviceCommunication: BingoCommunication {
  var host: BingoUserProfile?
  
  var joinee: BingoUserProfile?
  
  let deviceGridModel = BingoGridModel()
  
  var messageSubject: CurrentValueSubject<BingoMessageModel, Never> {
    .init(.waitingForPlayerToJoin)
  }
  
  var messagePublisher: AnyPublisher<BingoMessageModel, Never> {
    messageSubject.eraseToAnyPublisher()
  }
  
  func sendEvent(message: BingoMessageModel) {
    
  }
  
  var canSendEvent = true
}
