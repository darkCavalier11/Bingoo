//
//  BingooApp.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 27/04/24.
//

import SwiftUI

@main
struct BingooApp: App {
    @State private var bingoState = BingoState()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(bingoState)
        }
    }
}
