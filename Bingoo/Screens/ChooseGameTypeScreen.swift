//
//  ChooseGameTypeScreen.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 06/05/24.
//

import SwiftUI

struct ChooseGameTypeScreen: View {
    @State private var isPresented = false
    var body: some View {
        VStack(alignment: .leading) {
            ChooseGameTypeButton(gameType: .withDevice, systemImage: "cpu") {
                
            }
            HStack {
                ChooseGameTypeButton(gameType: .withLocalFriend, systemImage: "person") {
                    
                }
                HStack {
                    Button {
                        isPresented = true
                    } label: {
                        Text("JOIN")
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Divider()
                        .frame(height: 25)
                    
                    Button {
                        
                    } label: {
                        Text("HOST")
                    }
                }
                .alert(isPresented: $isPresented) {
                    Alert(title: Text("Hello"))
                }
            }
            
            HStack {
                ChooseGameTypeButton(gameType: .online, systemImage: "network") {
                    
                }
                HStack {
                    Button {
                        
                    } label: {
                        Text("JOIN")
                    }
                    .buttonStyle(.borderedProminent)
                    Divider()
                        .frame(height: 25)
                    
                    Button {
                        
                    } label: {
                        Text("HOST")
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
    ChooseGameTypeScreen()
}
