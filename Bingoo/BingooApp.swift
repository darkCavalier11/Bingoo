//
//  BingooApp.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 27/04/24.
//

import SwiftUI

@main
struct BingooApp: App {
    @State private var isUserLoggedIn = CDBingoUserModel.current?.userName != nil
    @State private var isGameStarted = false
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
            if isGameStarted {
                GameRunningScreen()
                    .environment(AppState())
            } else {
                ChooseGameTypeScreen(isGameStarted: $isGameStarted)
            }
            
        }
    }
}
