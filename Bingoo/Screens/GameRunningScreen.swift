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

}

#Preview {
    @State var appState = AppState()
    return GameRunningScreen()
        .environment(appState)
}
