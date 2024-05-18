//
//  ContentView.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 27/04/24.
//

import SwiftUI

struct GameRunningScreen: View {
    @Environment(AppState.self) var appState
    @State private var showError: Bool = false
    let bingo: [Character] = ["B","I","N","G","O"]
    var body: some View {
        NavigationStack {
            BingoGridView(gridElements: appState.bingoState.gridElements)
        }
    }
}

#Preview {
    @State var appState = AppState()
    return GameRunningScreen()
        .environment(appState)
}
