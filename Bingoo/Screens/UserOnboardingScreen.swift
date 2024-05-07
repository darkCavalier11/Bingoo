//
//  UserOnboardingScreen.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 06/05/24.
//

import SwiftUI

struct UserOnboardingScreen: View {
    @State var userName: String = ""
    var body: some View {
        VStack(alignment: .center) {
            Text("Let's Begin")
                .font(.largeTitle.monospaced().bold())
                .foregroundStyle(.accent)
            TextField("Name", text: $userName)
                .font(.largeTitle.monospaced().bold())
                .frame(width: 400)
                .padding()
            
            HStack {
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                }
                .frame(width: 60, height: 60)
                .background(.accent)
                .cornerRadius(30)
                .clipped()
            }
            .frame(width: 400)
        }
    }
}

#Preview {
    UserOnboardingScreen()
}
