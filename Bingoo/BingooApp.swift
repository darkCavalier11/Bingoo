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
    
    /// For now we will ignore the Username property, will integrate at the end.
    @State var userName = UserDefaults.standard.string(forKey: UserDefaultKeys.userName)
    var body: some Scene {
        WindowGroup {
            ChooseGameTypeScreen()
        }
    }
    
    @ViewBuilder
    var contentView: some View {
        if userName == nil {
            UserOnboardingScreen()
        } else {
            ChooseGameTypeScreen()
        }
    }
}
