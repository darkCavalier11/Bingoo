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
    @State var errorHappened = false
    @State var errorReason: String?
    @State private var host: BingoUserProfile?
    @State private var joinee: BingoUserProfile?
    @State private var winnerProfile: WinnerProfile?
    
    @State private var showExitDialog = false
  
    private struct WinnerProfile: Identifiable {
      let id = UUID()
      let profile: BingoUserProfile
      let gridModel: BingoGridModel
    }
  
    var body: some View {
        ZStack {
          BingoGridView(
            bingoState: appState.bingoState,
            comm: appState.comm
          )
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
                  try? appState.comm.sendEvent(message: .failure(reason: "\(BingoUserProfile.current.userName) exited the game."))
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
              self.errorHappened = true
              self.errorReason = reason
            case .playerWon(userProfile: let profile, bingoState: let gridModel):
              print("Player won \(profile.userName)")
              self.winnerProfile = WinnerProfile(profile: profile, gridModel: gridModel)
            case .playerJoined(userProfile: let userProfile):
              print("Player joined \(userProfile)")
              self.joinee = userProfile
            case .started(host: let host, joinee: let joinee):
              print("Started game with Host: \(host.userName) & Joinee: \(joinee.userName)")
              self.host = host
              self.joinee = joinee
            case .waitingForPlayerToJoin:
              print("Waiting for player to join")
            case .receiveUpdateWith(selectedNumber: let selectedNumber, userProfile: let userProfile):
              Task {
                await MainActor.run {
                  appState.bingoState.setSelectedFor(num: selectedNumber)
                  
                  if appState.bingoState.totalCompletedTileGroups >= 5 {
                    try? appState.comm.sendEvent(
                      message: .playerWon(
                        userProfile: currentUserProfile,
                        bingoState: appState.bingoState
                      )
                    )
                  }
                }
              }
            }
          }
          .store(in: &cancellable)
        }
        .alert(isPresented: $errorHappened, error: errorReason) {
          Button("OK") {
            isGameStarted = false
          }
        }
        .sheet(item: $winnerProfile) { winnerProfile in
          VStack {
            Text("\(winnerProfile.profile.userName) won the game!")
              .font(.title)
            BingoGridView(bingoState: winnerProfile.gridModel)
          }
          .onDisappear {
            isGameStarted = false
          }
        }
    }
}

extension String: LocalizedError {
  public var errorDescription: String? { self }
}
