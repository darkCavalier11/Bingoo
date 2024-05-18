//
//  Extensions.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 11/05/24.
//

import Foundation

extension BingoGridModel {
    public enum BingoGameRunningState {
        case active(isRunning: Bool)
        case failure(reason: Error)
        case playerWon(withGrid: [GridTileModel], userId: UUID)
    }
}
