//
//  ChooseGameTypeButton.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 07/05/24.
//

import SwiftUI

struct ChooseGameTypeButton: View {
    let gameType: BingoGameType
    let systemImage: String
    let onTap: () -> Void
    var body: some View {
        HStack {
            Rectangle()
                .frame(width: 10, height: 50)
                .foregroundStyle(.accent)
            Button {
                onTap()
            } label: {
                Label(gameType.rawValue, systemImage: systemImage)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.black)
            }
            .padding()
        }
    }
}

#Preview {
    ChooseGameTypeButton(gameType: .withDevice, systemImage: "cpu") {
        
    }
}
