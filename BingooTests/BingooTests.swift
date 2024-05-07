//
//  BingooTests.swift
//  BingooTests
//
//  Created by Sumit Pradhan on 27/04/24.
//

import XCTest
import Bingoo

final class BingooTests: XCTestCase {
    var bingoState: BingoGridModel!
    
    override func setUpWithError() throws {
        bingoState = BingoGridModel()
        bingoState.generateRandomGridTileElements()
    }

    override func tearDownWithError() throws {
        bingoState = nil
    }
    
    
    func testMarkingGridTile() {
        XCTAssert(bingoState.completedGridGroups.isEmpty)
        XCTAssert(bingoState.totalCompletedTileGroups == 0)
        XCTAssert(bingoState.gridElements.count == 25)
        
        bingoState.setSelectedFor(index: 0)
        XCTAssertTrue(bingoState.gridElements[0].isSelected)
        
        for i in 1..<25 {
            XCTAssertFalse(bingoState.gridElements[i].isSelected)
        }
    }
    
    func testMarkingRow() {
        let r = [0,1,2,3,4].randomElement()!
        
        for i in 0..<5 {
            bingoState.setSelectedFor(index: r*5 + i)
        }
        
        XCTAssertFalse(bingoState.completedGridGroups.isEmpty)
        XCTAssert(bingoState.totalCompletedTileGroups == 1)
        let completedGroupItem = bingoState.completedGridGroups[0]
        XCTAssert(completedGroupItem == .row(r))
    }
    
    func testMarkingColumn() {
        let r = [0,1,2,3,4].randomElement()!
        
        for i in 0..<5 {
            bingoState.setSelectedFor(index: i*5)
        }
        
        XCTAssertFalse(bingoState.completedGridGroups.isEmpty)
        XCTAssert(bingoState.totalCompletedTileGroups == 1)
        let completedGroupItem = bingoState.completedGridGroups[0]
        XCTAssert(completedGroupItem == .column(0))
    }
    
    func testMarkingTopLeftToBottomRightDiagonal() {
        let r = [0,1,2,3,4].randomElement()!
        
        for i in 0..<5 {
            bingoState.setSelectedFor(index: i + i*5)
        }
        
        XCTAssertFalse(bingoState.completedGridGroups.isEmpty)
        XCTAssert(bingoState.totalCompletedTileGroups == 1)
        let completedGroupItem = bingoState.completedGridGroups[0]
        XCTAssert(completedGroupItem == .diagonal(.topLeftToBottomRight))
    }
    
    func testMarkingBottomLeftToTopRightDiagonal() {
        let r = [0,1,2,3,4].randomElement()!
        
        for i in 0..<5 {
            bingoState.setSelectedFor(index: 4 - i + i*5)
        }
        
        XCTAssertFalse(bingoState.completedGridGroups.isEmpty)
        XCTAssert(bingoState.totalCompletedTileGroups == 1)
        let completedGroupItem = bingoState.completedGridGroups[0]
        XCTAssert(completedGroupItem == .diagonal(.bottomLeftToTopRight))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
