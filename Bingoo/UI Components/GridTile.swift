//
//  GridTile.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 27/04/24.
//

import SwiftUI

struct GridTile: View {
    let gridTileModel: GridTileModel
    let setSelected: (_ index: Int) -> Void
    
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
    @Environment(\.colorScheme) var colorScheme
    @State private var xShadowOffset = 4.0
    @State private var yShadowOffset = 4.0
    @State private var scaleFactor = 1.0
    @State private var textRotationFactor = 0.0
    @State private var gridTileForegroundColor: Color? = nil
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: Self.rectangleFrame.width, height: Self.rectangleFrame.height)
                .cornerRadius(12)
                .shadow(color: .orange, radius: 0, x: xShadowOffset, y: yShadowOffset)
                .scaleEffect(scaleFactor)
                .foregroundStyle(gridTileForegroundColor == nil ? colorScheme == .dark ? .black : .white : gridTileForegroundColor!)
                .padding(Self.itemPadding)
                
            Text("\(gridTileModel.number)")
                .font(.title2.monospaced().bold())
                .rotationEffect(Angle(radians: textRotationFactor))
        }
        .onTapGesture {
            setSelected(gridTileModel.index)
        }
        .onChange(of: gridTileModel.isSelected) {
            withAnimation(.easeInOut(duration: 0.4)) {
                scaleFactor = 1.2
                textRotationFactor = Double.pi * 6
            }
            Task {
                try await Task.sleep(for: .seconds(0.4))
                await MainActor.run {
                    withAnimation {
                        xShadowOffset = 0
                        yShadowOffset = 0
                        gridTileForegroundColor = .accent
                        scaleFactor = 1.0
                    }
                    
                }
            }
        }
    }
}

#Preview {
    GridTile(gridTileModel: GridTileModel(number: 0, index: 0, isSelected: false)) { index in
        
    }
}
