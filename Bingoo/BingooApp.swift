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
    let userName = UserDefaults.standard.string(forKey: UserDefaultKeys.userName)
    var body: some Scene {
        WindowGroup {
            contentView
        }
    }
    
    @ViewBuilder
    var contentView: some View {
        if userName == nil {
            UserOnboardingScreen()
        } else {
            ContentView()
        }
    }
}
