//
//  BingoCommunicationProtocol.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 09/05/24.
//

import Foundation

protocol BingoCommunicationProtocol {
    func onNewUserJoin(user: BingoUserModel)
    func syncBingoManagerModel(bingoManager model: BingoGridMessageModel)
    func onReceive(bingoManager model: BingoGridMessageModel)
}
