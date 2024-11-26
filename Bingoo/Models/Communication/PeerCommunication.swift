//
//  PeerCommunication.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 19/11/24.
//

import Foundation
import MultipeerConnectivity
import Combine

//class PeerCommunication: NSObject, BingoCommunication {
//  let lnc = LocalNetworkSessionCoordinator()
//  
//  override init() {
//    super.init()
//  }
//  
//  func sendEvent(message: BingoMessageModel) {
//    
//  }
//  
//  var messagePublisherSubject = CurrentValueSubject<BingoMessageModel, Never>(.waitingForPlayerToJoin)
//  
//  var messagePublisher: AnyPublisher<BingoMessageModel, Never> {
//    messagePublisherSubject.eraseToAnyPublisher()
//  }
//  
//  var canSendEvent: Bool = false
//  
//  var host: BingoUserProfile?
//  
//  var joinee: BingoUserProfile?
//  
//  
//}
