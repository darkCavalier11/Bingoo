//
//  GridTile.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 27/04/24.
//

import SwiftUI

struct GridTile: View {
    let number: Int
    init(number: Int) {
        self.number = number
    }
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
            Rectangle()
                .frame(width: Self.rectangleFrame.width, height: Self.rectangleFrame.height)
                .cornerRadius(12)
                .shadow(color: .orange, radius: 0, x: 4, y: 4)
                .foregroundColor(.white)
                .padding(Self.itemPadding)
            Text("\(number)")
                .font(.system(size: 36, weight: .bold, design: .monospaced))
        }
    }
}

#Preview {
    GridTile(number: 0)
}
