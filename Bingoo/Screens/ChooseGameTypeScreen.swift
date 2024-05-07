//
//  ChooseGameTypeScreen.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 06/05/24.
//

import SwiftUI

struct ChooseGameTypeScreen: View {
    var body: some View {
        VStack(alignment: .leading) {
            ChooseGameTypeButton(gameType: .withDevice, systemImage: "cpu") {
                
            }
            ChooseGameTypeButton(gameType: .withLocalFriend, systemImage: "person") {
                
            }
            ChooseGameTypeButton(gameType: .online, systemImage: "network") {

            }
        }
    }
}

#Preview {
    ChooseGameTypeScreen()
}
