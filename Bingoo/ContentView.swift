//
//  ContentView.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 27/04/24.
//

import SwiftUI

struct ContentView: View {
    private let gridFrame = CGSize(width: GridTile.itemSize.height * 5, height: GridTile.itemSize.width * 5)
    @State var gridTileElements: [GridTileModel] = []
    
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
                ForEach(gridTileElements, id: \.position) { element in
                    GridTile(number: element.number)
                        .offset(positionElement(row: element.row, column: element.column))
                }
            }
            .onAppear {
                generateRandomGridTileElements()
            }
            Button {
                
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
    
    func generateRandomGridTileElements() {
        var unusedNumbers: [Int] = []
        for i in 0..<25 {
            unusedNumbers.append(i + 1)
        }
        
        for i in 0..<25 {
            let randomNumber = unusedNumbers.randomElement()!
            let index = unusedNumbers.firstIndex(of: randomNumber)!
            unusedNumbers.remove(at: index)
            gridTileElements.append(GridTileModel(number: randomNumber, position: i))
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
    ContentView()
}
