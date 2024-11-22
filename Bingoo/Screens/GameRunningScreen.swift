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
          let currentUserProfile = BingoUserProfile.current
          appState.comm.messagePublisher.sink { message in
            switch message {
            case .failure(reason: let reason):
              isGameStarted = false
            case .playerWon(userProfile: let profile, gridElements: let gridElements):
              print("Player won \(profile.userName)")
            case .playerJoined(userProfile: let userProfile):
              print("Player joined \(userProfile)")
            case .started(host: let host, joinee: let joinee):
              print("Started game with Host: \(host.userName) & Joinee: \(joinee.userName)")
            case .waitingForPlayerToJoin:
              print("Waiting for player to join")
            case .receiveUpdateWith(selectedNumber: let selectedNumber, userProfile: let userProfile):
              appState.bingoState.setSelectedFor(index: selectedNumber)
              
              if appState.bingoState.totalCompletedTileGroups == 5 {
                try? appState.comm.sendEvent(
                  message: .playerWon(
                    userProfile: currentUserProfile,
                    gridElements: appState.bingoState.gridElements
                  )
                )
              }
            }
          }
          .store(in: &cancellable)
        }
    }
}

