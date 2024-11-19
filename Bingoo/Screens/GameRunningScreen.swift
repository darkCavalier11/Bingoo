//
//  ContentView.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 27/04/24.
//

import SwiftUI
import CustomAlert
import Combine

private var cancellable = Set<AnyCancellable>()
struct GameRunningScreen: View {
    @Environment(AppState.self) var appState
    @Binding var isGameStarted: Bool
    
    @State private var showExitDialog = false
    var body: some View {
        ZStack {
            BingoGridView(gridElements: appState.bingoState.gridElements)
            Button {
                showExitDialog = true
            } label: {
                Text("Exit")
            }
            .offset(x: GridTile.itemSize.width * 2.5 - 10, y: GridTile.itemSize.height * 4.5)
            .buttonStyle(.borderedProminent)
        }
        .customAlert("Exit", isPresented: $showExitDialog) {
            Text("Are you sure want to exit?")
        } actions: {
            MultiButton {
                Button(role: .cancel) {
                    
                } label: {
                    Text("Cancel")
                }
                
                Button {
                    isGameStarted = false
                } label: {
                    Text("Exit")
                }
            }
        }
        .onAppear {
          appState.comm.messagePublisher.sink { message in
            switch message {
            case .failure(reason: let reason):
              break
            case .playerWon(userProfile: let profile, gridElements: let gridElements):
              break
            case .started(host: let host, joinee: let joinee):
              break
            case .waitingForPlayerToJoin:
              break
            case .receiveUpdateWith(selectedNumber: let selectedNumber, userProfile: let userProfile):
              break
            }
          }
          .store(in: &cancellable)
        }
    }
}

