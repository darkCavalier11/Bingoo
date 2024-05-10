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
    @State var val = 0
    var body: some View {
        HStack {
            Rectangle()
                .frame(width: 10, height: 50)
                .foregroundStyle(.accent)
                .cornerRadius(6)
                .clipped()
            Button {
                onTap()
            } label: {
                Label(
                    title: { 
                        Text(gameType.rawValue)
                            .font(.title.monospaced())
                            .foregroundStyle(.black)
                    },
                    icon: { 
                        Image(systemName: systemImage)
                            .font(.title)
                            .foregroundStyle(.white)
                            .padding(.init(top: 6, leading: 6, bottom: 6, trailing: 6))
                            .background(Circle())
                    }
                )
            }
            .padding()
        }
    }
}

#Preview {
    ChooseGameTypeButton(gameType: .withDevice, systemImage: "cpu") {
        
    }
}
