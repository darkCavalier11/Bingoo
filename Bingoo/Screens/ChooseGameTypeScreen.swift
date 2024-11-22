//
//  ChooseGameTypeScreen.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 06/05/24.
//

import SwiftUI
import CustomAlert
import MultipeerConnectivity
import Combine

private var cancellable = Set<AnyCancellable>()
struct ChooseGameTypeScreen: View {
    @State private var showChooseDeviceDialog = false
    @State private var showEnterJoiningCodeDialog = false
    
    @State private var isHostingStartedForPeer = false
    @State private var showPeerJoiningDialog = false
    @State private var peerID: MCPeerID?
    
    @State private var joiningCode = ""
    @Binding var isGameStarted: Bool
    @Binding var gameType: BingoGameType
    @State private var lnsc = LocalNetworkSessionCoordinator()
    
  func resetValues() {
    showChooseDeviceDialog = false
    showEnterJoiningCodeDialog = false
    isHostingStartedForPeer = false
    showPeerJoiningDialog = false
  }
  
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ChooseGameTypeLabel(
                  gameType: .withDevice,
                  systemImage: "cpu"
                )
                Button {
                  isGameStarted = true
                  gameType = .withDevice
                } label: {
                    Text("START")
                }
                .buttonStyle(.borderedProminent)
            }
            HStack {
                ChooseGameTypeLabel(
                  gameType: .withLocalFriend,
                  systemImage: "person"
                )
                HStack {
                    Button {
                      lnsc.startBrowsing()
                      resetValues()
                      showChooseDeviceDialog = true
                    } label: {
                        Text("JOIN")
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Divider()
                        .frame(height: 25)
                    
                    Button {
                      lnsc.startAdvertising()
                      resetValues()
                      isHostingStartedForPeer = true
                    } label: {
                      isHostingStartedForPeer ? AnyView(ProgressView()) : AnyView(Text("HOST"))
                    }
                }
                .customAlert("Choose Device", isPresented: $showChooseDeviceDialog
                ) {
                  ForEach(Array(lnsc.allDevices), id: \.self) { peerID in
                        VStack {
                            Button {
                              lnsc.invitePeer(peerID: peerID)
                              
                            } label: {
                              Text("\(peerID.displayName)")
                            }
                            .padding()
                            .font(.title3)
                        }
                        Divider()
                    }
                    ProgressView()
                } actions: {
                    Button(role: .cancel) {
                        
                    } label: {
                        Text("Cancel")
                    }
                }
            }
            .onAppear {
              lnsc.incomingInvitationPeers.receive(on: DispatchQueue.main)
                .sink { peerID in
                  guard let peerID else { return }
                  self.peerID = peerID
                  showPeerJoiningDialog = true
                }
                .store(in: &cancellable)
            }
            .customAlert(isPresented: $showPeerJoiningDialog) {
              Text("Do you want to start a game with \(peerID?.displayName ?? "-")?")
            } actions: {
              MultiButton {
                Button {
                  lnsc.acceptingInvitationPeerSubject.send(self.peerID)
                } label: {
                  Text("Accept")
                }
                Button(role: .cancel) {
                  
                } label: {
                  Text("Cancel")
                }
              }
            }
            
            HStack {
                ChooseGameTypeLabel(gameType: .online, systemImage: "network")
                HStack {
                    Button {
                      resetValues()
                      showEnterJoiningCodeDialog = true
                      
                    } label: {
                        Text("JOIN")
                    }
                    .buttonStyle(.borderedProminent)
                    Divider()
                        .frame(height: 25)
                    
                    Button {
                        isGameStarted = true
                      resetValues()
                    } label: {
                        Text("HOST")
                    }
                }
            }
            .customAlert("Enter joining code", isPresented: $showEnterJoiningCodeDialog) {
                TextField(text: $joiningCode) {
                    
                }
                .font(.title)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
            } actions: {
                MultiButton {
                    Button {
                        
                    } label: {
                        Text("Join")
                    }
                    Button(role: .cancel) {
                        
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
    }
}

public enum BingoGameType: String, CaseIterable, Codable {
    case withDevice = "With Device"
    case withLocalFriend = "With Local Friends"
    case online = "Online"
}

#Preview {
  @Previewable @State var isGameStarted = false
  @Previewable @State var gameType = BingoGameType.withDevice
  return ChooseGameTypeScreen(isGameStarted: $isGameStarted, gameType: $gameType)
}
