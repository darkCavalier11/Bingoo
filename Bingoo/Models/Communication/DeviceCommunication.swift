//
//  LocalCommunication.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 19/11/24.
//

import Foundation
import Combine

class DeviceCommunication: BingoCommunication {
  var host: BingoUserProfile? {
    BingoUserProfile.current
  }
  
  var joinee: BingoUserProfile? {
    BingoUserProfile(id: UUID(), userName: "Device")
  }
  
  
  let deviceGridModel = BingoGridModel()
  
  var messageSubject = CurrentValueSubject<BingoMessageModel, Never>(
    .started(
        host: BingoUserProfile.current,
        joinee: BingoUserProfile(id: UUID(), userName: "Device"
                              )
      )
    )
  
  
  init() {
    deviceGridModel.generateRandomGridTileElements()
  }
  
  var messagePublisher: AnyPublisher<BingoMessageModel, Never> {
    messageSubject.eraseToAnyPublisher()
  }
  
  func sendEvent(message: BingoMessageModel) {
    if case BingoMessageModel.receiveUpdateWith(selectedNumber: let index, userProfile: let profile) = message {
      messageSubject.send(message)
      Task {
        deviceGridModel.setSelectedFor(index: index)
        if deviceGridModel.totalCompletedTileGroups == 5 {
          messageSubject.send(.playerWon(userProfile: joinee!, gridElements: deviceGridModel.gridElements))
          messageSubject.send(completion: .finished)
          return
        }
        await MainActor.run {
          canSendEvent = false
        }
        try await Task.sleep(for: .milliseconds(1500))
        let nonSelectedIndices = deviceGridModel.gridElements.filter { !$0.isSelected }
        guard let deviceSelectedNumber = nonSelectedIndices.randomElement() else { return }
        let index = deviceSelectedNumber.index
        deviceGridModel.setSelectedFor(index: index)
        if deviceGridModel.totalCompletedTileGroups == 0 {
          messageSubject.send(.playerWon(userProfile: joinee!, gridElements: deviceGridModel.gridElements))
          messageSubject.send(completion: .finished)
        }
        messageSubject.send(.receiveUpdateWith(selectedNumber: index, userProfile: profile))
        
        await MainActor.run {
          canSendEvent = true
        }
        
      }
    }
    
    if case BingoMessageModel.playerWon(userProfile: let userProfile, gridElements: let gridElements) = message {
      messageSubject.send(message)
      messageSubject.send(completion: .finished)
    }
  }
  
  @MainActor var canSendEvent = true
}
