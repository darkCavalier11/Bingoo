//
//  BingooApp.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 27/04/24.
//

import SwiftUI

@main
struct BingooApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  
    @State private var isUserLoggedIn = CDBingoUserModel.current?.userName != nil
    @State private var isGameStarted = false
    @State private var gameType: BingoGameType = .withDevice
    @State private var comm: BingoCommunication = DeviceCommunication()
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
                GameRunningScreen(isGameStarted: $isGameStarted)
                    .environment(
                      AppState(
                        comm: comm
                      )
                    )
            } else {
                ChooseGameTypeScreen(
                  isGameStarted: $isGameStarted,
                  comm: $comm
                )
            }
            
        }
    }
}
