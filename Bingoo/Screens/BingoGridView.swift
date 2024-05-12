//
//  BingoGridView.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 11/05/24.
//

import SwiftUI

struct BingoGridView: View {
    private let gridFrame = CGSize(width: GridTile.itemSize.height * 5, height: GridTile.itemSize.width * 5)
    
    var gridElements: [GridTileModel]
    @Environment(AppState.self) var appState
    var body: some View {
        let bingo: [Character] = ["B","I","N","G","O"]
        VStack {
            ZStack {
                Rectangle()
                    .frame(width: gridFrame.width, height: GridTile.itemSize.height)
                    .foregroundStyle(.white)
                ForEach(0..<5) { idx in
                    GridHeaderText(letter: bingo[idx], isCompleted: appState.bingoState.totalCompletedTileGroups  > idx)
                        .offset(positionGridHeaderText(index: idx))
                }
            }
            ZStack {
                Rectangle()
                    .frame(width: gridFrame.width, height: gridFrame.height)
                    .foregroundColor(.white)
                ForEach(gridElements) { element in
                    GridTile(gridTileModel: element) { index in
                        appState.bingoState.setSelectedFor(index: index)
                    }
                        .offset(positionElement(row: element.row, column: element.column))
                }
                GridTileGroupCrossViews(crossLineFrameWidths: appState.bingoState.crossLineFrameWidths, crossLineFrameHeights: appState.bingoState.crossLineFrameHeights)
            }
        }
        .onAppear {
            appState.bingoState.generateRandomGridTileElements()
        }
        .onChange(of: appState.bingoState.completedGridGroups) { _, curr in
            if curr.isEmpty {
                return
            }
            
            for item in curr {
                switch item {
                case .row(let rowIndex):
                    appState.bingoState.markRow(rowIndex)
                case .column(let colIndex):
                    appState.bingoState.markColumn(colIndex)
                case .diagonal(let diagonalType):
                    appState.bingoState.markDiagonal(diagonalType)
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

