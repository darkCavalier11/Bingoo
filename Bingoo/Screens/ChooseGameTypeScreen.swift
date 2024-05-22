//
//  ChooseGameTypeScreen.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 06/05/24.
//

import SwiftUI
import CustomAlert

struct ChooseGameTypeScreen: View {
    @State private var showChooseDeviceDialog = false
    @State private var showEnterJoiningCodeDialog = false
    @State private var joiningCode = ""
    @Binding var isGameStarted: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ChooseGameTypeLabel(gameType: .withDevice, systemImage: "cpu")
                Button {
                    
                } label: {
                    Text("START")
                }
                .buttonStyle(.borderedProminent)
            }
            HStack {
                ChooseGameTypeLabel(gameType: .withLocalFriend, systemImage: "person")
                HStack {
                    Button {
                        showChooseDeviceDialog = true
                    } label: {
                        Text("JOIN")
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Divider()
                        .frame(height: 25)
                    
                    Button {
                        isGameStarted = true
                    } label: {
                        Text("HOST")
                    }
                }
                .customAlert("Choose Device", isPresented: $showChooseDeviceDialog) {
                    ForEach(0..<10) { e in
                        VStack {
                            Button {
                                
                            } label: {
                                Text("\(e)")
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
                            .font(.title)
                    }
                }
            }
            
            HStack {
                ChooseGameTypeLabel(gameType: .online, systemImage: "network")
                HStack {
                    Button {
                        showEnterJoiningCodeDialog = true
                    } label: {
                        Text("JOIN")
                    }
                    .buttonStyle(.borderedProminent)
                    Divider()
                        .frame(height: 25)
                    
                    Button {
                        isGameStarted = true
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
    @State var isGameStarted = false
    return ChooseGameTypeScreen(isGameStarted: $isGameStarted)
}
