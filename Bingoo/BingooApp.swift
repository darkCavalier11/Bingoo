//
//  BingooApp.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 27/04/24.
//

import SwiftUI

@main
struct BingooApp: App {
    @State private var appState = AppState()
    @State private var isUserLoggedIn = BingoUserModel.current?.userName != nil
    var body: some Scene {
        WindowGroup {
            contentView
        }
    }
    
    @ViewBuilder
    var contentView: some View {
        if !isUserLoggedIn {
            UserOnboardingScreen(isLoggedIn: $isUserLoggedIn)
        } else {
            ChooseGameTypeScreen()
        }
    }
}
