//
//  ChooseGameTypeButton.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 07/05/24.
//

import SwiftUI

struct ChooseGameTypeLabel: View {
    let gameType: BingoGameType
    let systemImage: String
    @State var val = 0
    var body: some View {
        HStack {
            Rectangle()
                .frame(width: 10, height: 50)
                .foregroundStyle(.accent)
                .cornerRadius(6)
                .clipped()
            Button {
                
            } label: {
                Label(
                    title: { 
                        Text(gameType.rawValue)
                            .font(.headline.monospaced())
                            .foregroundStyle(.foreground)
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
    ChooseGameTypeLabel(gameType: .withDevice, systemImage: "cpu")
}
