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
  
  private var cancellable = Set<AnyCancellable>()
  
  var host: BingoUserProfile?
  
  var joinee: BingoUserProfile?
  
  var roundCompleted = 0
  
  let joiningCode: String
  let isHost: Bool
  init(joiningCode: String, isHost: Bool) {
    self.joiningCode = joiningCode
    self.isHost = isHost
    
    super.init()
    
    messageSubject
      .sink { [weak self] message in
        if case BingoMessageModel.receiveUpdateWith(selectedNumber: _, userProfile: _) = message {
          self?.roundCompleted += 1
        }
      }
      .store(in: &cancellable)
    
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
      
      if case BingoMessageModel.playerWon(userProfile: _, bingoState: _) = message {
        self?.messageSubject.send(completion: .finished)
      }
      if case BingoMessageModel.failure(reason: _) = message {
        self?.messageSubject.send(completion: .finished)
      }
    }
    
    if !isHost {
      sendEvent(message: .playerJoined(userProfile: BingoUserProfile.current))
    } else {
      sendEvent(message: .waitingForPlayerToJoin(hostProfile: BingoUserProfile.current))
    }
  }
  
  private lazy var databasePath: DatabaseReference? = {
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
  
  var canSendEvent: Bool {
    if isHost && roundCompleted%2 == 0 {
      return true
    } else if !isHost && roundCompleted%2 != 0 {
      return true
    }
    return false
  }
}
