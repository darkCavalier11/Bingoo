//
//  ContentView.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 27/04/24.
//

import SwiftUI

struct ContentView: View {
    private let gridFrame = CGSize(width: GridTile.itemSize.height * 5, height: GridTile.itemSize.width * 5)
    @Environment(BingoState.self) var bingoState
    
    let bingo: [Character] = ["B","I","N","G","O"]
    var body: some View {
        @Bindable var bingoState: BingoState = bingoState
        
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
                ForEach(bingoState.gridElements) { element in
                    GridTile(gridTileModel: element) { index in
                        bingoState.setSelectedFor(index: index)
                    }
                        .offset(positionElement(row: element.row, column: element.column))
                }
            }
            .onAppear {
                bingoState.generateRandomGridTileElements()
            }
            Button {
                bingoState.generateRandomGridTileElements()
            } label: {
                Image(systemName: "goforward")
                    .resizable()
                    .scaledToFill()
                    .foregroundStyle(.white)
                    .frame(width: 30, height: 30)
            }
            .padding()
            .background(.accent)
            .cornerRadius(10)
            .offset(x: gridFrame.width / 2 - 15)
            
        }
    }
    
    func positionGridHeaderText(index: Int) -> CGSize {
        let xOffset = Double(index) * GridHeaderText.itemSize.width
        return CGSize(width: xOffset - gridFrame.width / 2 + GridHeaderText.itemSize.width / 2, height: 0)
    }
    func positionElement(row: Int, column: Int) -> CGSize {
        let xOffset = Double(row) * GridTile.itemSize.width
        let yOffset = Double(column) * GridTile.itemSize.height
        
        return CGSize(width: yOffset - gridFrame.width / 2 + GridTile.itemSize.width / 2, height: xOffset - gridFrame.height / 2 + GridTile.itemSize.height / 2)
    }
}

#Preview {
    @State var bingoState = BingoState()
    return ContentView()
        .environment(bingoState)
}
