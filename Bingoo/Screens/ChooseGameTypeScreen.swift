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
    @Binding var comm: BingoCommunication
    @State private var lnsc: LocalNetworkSessionCoordinator?
    @State private var onlineCommunication: OnlineCommunication?
  
  func resetValues() {
    showChooseDeviceDialog = false
    showEnterJoiningCodeDialog = false
    isHostingStartedForPeer = false
    showPeerJoiningDialog = false
    lnsc?.stopBrowing()
    lnsc?.stopAdvertising()
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
                  comm = DeviceCommunication()
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
                      resetValues()
                      lnsc = LocalNetworkSessionCoordinator(isHost: false)
                      comm = lnsc!
                      lnsc?.startBrowsing()
                      showChooseDeviceDialog = true
                      lnsc?.messagePublisher
                        .receive(on: DispatchQueue.main)
                        .sink { message in
                          if case BingoMessageModel.started(
                            host: _,
                            joinee: _
                          ) = message {
                            isGameStarted = true
                          }
                        }
                        .store(in: &cancellable)
                    } label: {
                        Text("JOIN")
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Divider()
                        .frame(height: 25)
                    
                    Button {
                      resetValues()
                      lnsc = LocalNetworkSessionCoordinator(isHost: true)
                      comm = lnsc!
                      lnsc?.startAdvertising()
                      isHostingStartedForPeer = true
                      lnsc?
                        .incomingInvitationPeers
                        .sink { peerID in
                          guard let peerID else { return }
                          self.peerID = peerID
                          showPeerJoiningDialog = true
                        }
                        .store(in: &cancellable)
                      lnsc?.messagePublisher
                        .receive(on: DispatchQueue.main)
                        .sink { message in
                          if case BingoMessageModel.started(
                            host: _,
                            joinee: _
                          ) = message {
                            isGameStarted = true
                          }
                        }
                        .store(in: &cancellable)
                    } label: {
                      isHostingStartedForPeer ? AnyView(ProgressView().frame(width: 50)) : AnyView(Text("HOST"))
                    }
                }
                .customAlert("Choose Device", isPresented: $showChooseDeviceDialog
                ) {
                  ForEach(Array(lnsc?.allDevices ?? []), id: \.self) { peerID in
                        VStack {
                            Button {
                              lnsc?.invitePeer(peerID: peerID)
                              
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
            .onDisappear {
              lnsc?.stopBrowing()
              lnsc?.stopAdvertising()
              resetValues()
            }
            .customAlert(isPresented: $showPeerJoiningDialog) {
              Text("Do you want to start a game with \(peerID?.displayName ?? "-")?")
            } actions: {
              MultiButton {
                Button {
                  lnsc?.acceptingInvitationPeerSubject.send(self.peerID)
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
                      let joiningCode = "\(Int.random(in: 100000...999999))"
                      onlineCommunication = OnlineCommunication(joiningCode: joiningCode, isHost: true)
                      comm = onlineCommunication!
                      onlineCommunication?.messagePublisher
                        .receive(on: DispatchQueue.main)
                        .sink { message in
                          if case BingoMessageModel.started(host: let host, joinee: let joinee) = message {
                            isGameStarted = true
                          }
                        }
                        .store(in: &cancellable)
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
                      onlineCommunication = OnlineCommunication(joiningCode: joiningCode, isHost: false)
                      comm = onlineCommunication!
                      onlineCommunication?.messagePublisher
                        .receive(on: DispatchQueue.main)
                        .sink { message in
                          if case BingoMessageModel.started(host: let host, joinee: let joinee) = message {
                            isGameStarted = true
                          }
                        }
                        .store(in: &cancellable)
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
