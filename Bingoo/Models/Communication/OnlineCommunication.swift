//
//  OnlineCommunication.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 19/11/24.
//

import Foundation
import FirebaseDatabase
import Combine

class OnlineCommunication: NSObject, BingoCommunication {
  private let messageSubject = CurrentValueSubject<BingoMessageModel, Never>(.waitingForPlayerToJoin(hostProfile: BingoUserProfile.current))
  
  var messagePublisher: AnyPublisher<BingoMessageModel, Never> {
    messageSubject.eraseToAnyPublisher()
  }
  
  var canSendEvent: Bool = false
  
  var host: BingoUserProfile?
  
  var joinee: BingoUserProfile?
  
  let joiningCode: String
  let isHost: Bool
  init(joiningCode: String, isHost: Bool) {
    self.joiningCode = joiningCode
    self.isHost = isHost
    
    super.init()
    databasePath?
    .observe(.value) { [weak self] snapshot in
      guard let json = snapshot.value as? [String: Any] else { return }
      guard let data = try? JSONSerialization.data(withJSONObject: json) else { return }
      let decoder = JSONDecoder()
      guard let message = try? decoder.decode(BingoMessageModel.self, from: data) else { return }
      if case BingoMessageModel.playerJoined(userProfile: let userProfile) = message,
         self?.isHost == true {
        self?.sendEvent(message: .started(host: BingoUserProfile.current, joinee: userProfile))
      }
      self?.messageSubject.send(message)
    }
    
    if !isHost {
      sendEvent(message: .playerJoined(userProfile: BingoUserProfile.current))
    } else {
      sendEvent(message: .waitingForPlayerToJoin(hostProfile: BingoUserProfile.current))
    }
  }
  
  private lazy var databasePath: DatabaseReference? = {
    // 2
    let ref = Database.database()
      .reference()
      .child(joiningCode)
    return ref
  }()
  
  func sendEvent(message: BingoMessageModel) {
    let encoder = JSONEncoder()
    guard let data = try? encoder.encode(message) else { return }
    guard let json = try? JSONSerialization.jsonObject(with: data) else { return }
    guard let dict = json as? [String: Any] else { return }
    databasePath?.setValue(dict)
  }
}
