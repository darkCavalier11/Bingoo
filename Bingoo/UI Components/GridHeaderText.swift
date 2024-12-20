//
//  GridHeaderText.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 28/04/24.
//

import SwiftUI

struct GridHeaderText: View {
    @Environment(\.colorScheme) var colorScheme
    let letter: Character
    var isCompleted = false
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
    
    private static var itemPadding: Double {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return 6
        case .pad, .mac:
            return 12
        case .tv:
            return 16
        default:
            return 6
        }
    }
    
    static var itemSize: CGSize {
        return CGSize(width: rectangleFrame.width + 2.0 * itemPadding, height: rectangleFrame.height + 2.0 * itemPadding)
    }
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: Self.rectangleFrame.width, height: Self.rectangleFrame.height)
                .foregroundColor(isCompleted ? .accent : colorScheme == .light ? .white : .black)
                .shadow(color: .accent, radius: 0, x: isCompleted ? 0 : 6, y: 0)
            Text(letter.description)
                .font(.largeTitle.monospaced().weight(.black))
        }
        
    }
}

#Preview {
    GridHeaderText(letter: "C")
}
