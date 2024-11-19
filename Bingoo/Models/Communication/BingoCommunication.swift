//
//  BingoCommunicationProtocol.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 19/11/24.
//

import Foundation
import Combine

protocol BingoCommunication: AnyObject {
  func sendEvent(message: BingoMessageModel)
  var messagePublisher: AnyPublisher<BingoMessageModel, Never> { get }
  var canSendEvent: Bool { get }
}
