//
//  BingoGridView.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 11/05/24.
//

import SwiftUI

struct BingoGridView: View {
    private let gridFrame = CGSize(width: GridTile.itemSize.height * 5, height: GridTile.itemSize.width * 5)
    
    @State var bingoState: BingoGridModel
    var comm: BingoCommunication?
    var body: some View {
        let bingo: [Character] = ["B","I","N","G","O"]
        VStack {
            ZStack {
                Rectangle()
                    .frame(width: gridFrame.width, height: GridTile.itemSize.height)
                    .foregroundStyle(.background)
                ForEach(0..<5) { idx in
                    GridHeaderText(
                      letter: bingo[idx],
                      isCompleted: bingoState.totalCompletedTileGroups  > idx
                    )
                        .offset(positionGridHeaderText(index: idx))
                }
            }
            ZStack {
                Rectangle()
                    .frame(width: gridFrame.width, height: gridFrame.height)
                    .foregroundStyle(.background)
              ForEach(bingoState.gridElements) { element in
                  GridTile(gridTileModel: element) { index in
                    if comm?.canSendEvent == true {
                      try? comm?.sendEvent(
                        message: .receiveUpdateWith(
                          selectedNumber: index,
                          userProfile: BingoUserProfile.current
                        )
                      )
                    }
                  }
                  .offset(positionElement(row: element.row, column: element.column))
                }
                GridTileGroupCrossViews(
                  crossLineFrameWidths: bingoState.crossLineFrameWidths,
                  crossLineFrameHeights: bingoState.crossLineFrameHeights
                )
            }
        }
        .onChange(of: bingoState.completedGridGroups) { _, curr in
            if curr.isEmpty {
                return
            }
            
            for item in curr {
                switch item {
                case .row(let rowIndex):
                    bingoState.markRow(rowIndex)
                case .column(let colIndex):
                    bingoState.markColumn(colIndex)
                case .diagonal(let diagonalType):
                    bingoState.markDiagonal(diagonalType)
                }
            }
        }
    }
    
    func positionGridHeaderText(index: Int) -> CGSize {
        let xOffset = Double(index) * GridHeaderText.itemSize.width
        return CGSize(width: xOffset - gridFrame.width / 2 + GridHeaderText.itemSize.width / 2, height: 0)
    }
    func positionElement(row: Int, column: Int) -> CGSize {
        let xOffset = Double(row) * GridTile.itemSize.width
        let yOffset = Double(column) * GridTile.itemSize.height
        let width = yOffset - gridFrame.width / 2 + GridTile.itemSize.width / 2
        let height =  xOffset - gridFrame.height / 2 + GridTile.itemSize.height / 2
        return CGSize(width: width, height: height)
      
    }
    // TODO: - Make this part of model changes

}

