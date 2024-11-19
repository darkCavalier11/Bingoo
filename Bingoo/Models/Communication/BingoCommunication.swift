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
  var messageSubject: CurrentValueSubject<BingoMessageModel, Never> { get }
  var canSendEvent: Bool { get }
}
