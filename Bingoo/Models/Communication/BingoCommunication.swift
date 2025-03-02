//
//  BingoCommunicationProtocol.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 19/11/24.
//

import Foundation
import Combine

protocol BingoCommunication: AnyObject {
  func sendEvent(message: BingoMessageModel) throws
  var messagePublisher: AnyPublisher<BingoMessageModel, Never> { get }
  var canSendEvent: Bool { get }
  var host: BingoUserProfile? { get }
  var joinee: BingoUserProfile? { get }
}
