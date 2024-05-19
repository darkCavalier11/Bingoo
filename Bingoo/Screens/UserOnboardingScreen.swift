//
//  UserOnboardingScreen.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 06/05/24.
//

import SwiftUI

struct UserOnboardingScreen: View {
    @State var userName: String = ""
    @State var showInvalidUserNameAlert = false
    @Environment(\.dismiss) var dismiss
    @Binding var isLoggedIn: Bool
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
                    guard userName.count > 3 else {
                        showInvalidUserNameAlert = true
                        return
                    }
                    CDBingoUserModel.updateDetails(userName: userName)
                    isLoggedIn = true
                    dismiss()
                } label: {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                }
                .frame(width: 60, height: 60)
                .background(.accent)
                .cornerRadius(30)
                .clipped()
                .alert("Username must be at least 3 characters", isPresented: $showInvalidUserNameAlert) {
                    Button("OK", role: .cancel) {
                        
                    }
                }
            }
            .frame(width: 400)
        }
    }
}

#Preview {
    @State var isLoggedIn = true
    return UserOnboardingScreen(isLoggedIn: $isLoggedIn)
}
