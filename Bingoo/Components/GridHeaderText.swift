//
//  GridHeaderText.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 28/04/24.
//

import SwiftUI

struct GridHeaderText: View {
    let letter: Character
    private static var rectangleFrame: CGSize {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return CGSize(width: 55, height: 55)
        case .pad, .mac:
            return CGSize(width: 80, height: 80)
        case .tv:
            return CGSize(width: 100, height: 100)
        default:
            return CGSize(width: 60, height: 60)
        }
    }
    
    private static let itemPadding = 12.0
    
    static var itemSize: CGSize {
        return CGSize(width: rectangleFrame.width + 2.0 * itemPadding, height: rectangleFrame.height + 2.0 * itemPadding)
    }
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: Self.rectangleFrame.width, height: Self.rectangleFrame.height)
                .foregroundColor(.white)
                .shadow(color: .accent, radius: 0, x: 6, y: 0)
            Text(letter.description)
                .font(.system(size: 44, weight: .black, design: .monospaced))
        }
        
    }
}

#Preview {
    GridHeaderText(letter: "C")
}
