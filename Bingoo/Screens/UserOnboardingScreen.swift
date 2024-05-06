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
        TextField("Name", text: $userName)
    }
}

#Preview {
    UserOnboardingScreen()
}
