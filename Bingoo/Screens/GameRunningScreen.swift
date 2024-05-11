//
//  ContentView.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 27/04/24.
//

import SwiftUI

struct GameRunningScreen: View {
    private let gridFrame = CGSize(width: GridTile.itemSize.height * 5, height: GridTile.itemSize.width * 5)
    
    @State private var crossLineFrameWidths = Array(repeating: 0.0, count: 12)
    @State private var crossLineFrameHeights = Array(repeating: 0.0, count: 12)
    
    @Environment(AppState.self) var appState
    
    @State private var showError: Bool = false
    let bingo: [Character] = ["B","I","N","G","O"]
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .frame(width: gridFrame.width, height: GridTile.itemSize.height)
                    .foregroundStyle(.white)
                ForEach(0..<5) { idx in
                    GridHeaderText(letter: bingo[idx])
                        .offset(positionGridHeaderText(index: idx))
                }
            }
            ZStack {
                Rectangle()
                    .frame(width: gridFrame.width, height: gridFrame.height)
                    .foregroundColor(.white)
                ForEach(appState.bingoState.gridElements) { element in
                    GridTile(gridTileModel: element) { index in
                        appState.bingoState.setSelectedFor(index: index)
                    }
                        .offset(positionElement(row: element.row, column: element.column))
                }
                GridTileGroupCrossViews(crossLineFrameWidths: crossLineFrameWidths, crossLineFrameHeights: crossLineFrameHeights)
            }
            .onAppear {
                appState.bingoState.generateRandomGridTileElements()
            }
        }
        .onChange(of: appState.bingoState.completedGridGroups) { _, curr in
            if curr.isEmpty {
                return
            }
            
            for item in curr {
                switch item {
                case .row(let rowIndex):
                    markRow(rowIndex)
                case .column(let colIndex):
                    markColumn(colIndex)
                case .diagonal(let diagonalType):
                    markDiagonal(diagonalType)
                }
            }
        }
        .onChange(of: appState.bingoState.showError) { _, curr in
            if curr {
                showError = true
            }
        }
        .alert("Error", isPresented: $showError) {
            Button("OK", role: .none) {
                
            }
        } message: {
            Text("\(String(describing: appState.bingoState.gameError?.localizedDescription))")
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
    
    func markRow(_ rowIndex: Int) {
        crossLineFrameHeights[rowIndex] = 4
        withAnimation {
            crossLineFrameWidths[rowIndex] = 550
        }
    }
    
    func markColumn(_ colIndex: Int) {
        crossLineFrameHeights[colIndex + 5] = 4
        withAnimation {
            crossLineFrameWidths[colIndex + 5] = 550
        }
        
    }
    
    func markDiagonal(_ diagonalType: BingoGridModel.CompletedGridType.DiagonalDirection) {
        if diagonalType == .topLeftToBottomRight {
            crossLineFrameHeights[10] = 4
            withAnimation {
                crossLineFrameWidths[10] = 750
            }
            
        } else {
            crossLineFrameHeights[11] = 4
            withAnimation {
                crossLineFrameWidths[11] = 750
            }
        }
    }
}

#Preview {
    @State var appState = AppState()
    return GameRunningScreen()
        .environment(appState)
}
