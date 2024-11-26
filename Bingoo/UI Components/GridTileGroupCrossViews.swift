//
//  GridTileGroupCrossViews.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 09/05/24.
//

import SwiftUI

struct GridTileGroupCrossViews: View {
    let crossLineFrameWidths: [Double]
    let crossLineFrameHeights: [Double]
    var body: some View {
        /// Adding initial line for all rows, columns and diagonals and later
        /// animate it to fill the group.
        ///
        /// 1. Adding row cross lines
        ForEach(-2..<3) { idx in
            Rectangle()
                .frame(width: crossLineFrameWidths[idx + 2], height: crossLineFrameHeights[idx + 2])
                .offset(CGSize(width: 0, height: Double(idx) * GridTile.itemSize.height))
        }
        /// 2. Adding column cross lines
        ForEach(-2..<3) { idx in
            Rectangle()
                .frame(width: crossLineFrameWidths[idx + 7], height: crossLineFrameHeights[idx + 7])
                .offset(CGSize(width: 0, height: -Double(idx) * GridTile.itemSize.height))
                .rotationEffect(Angle(degrees: 90))
        }
        
        /// 3. Adding diagonal cross lines
        /// a. Top left to bottom to bottom right
        Rectangle()
            .frame(width: crossLineFrameWidths[10], height: crossLineFrameHeights[10])
            .rotationEffect(Angle(degrees: 45))
        /// b. bottom left to top right
        Rectangle()
            .frame(width: crossLineFrameWidths[11], height: crossLineFrameHeights[11])
            .rotationEffect(Angle(degrees: -45))
    }
}
