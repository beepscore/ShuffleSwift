//
//  BSShufflerTests.swift
//  ShuffleSwift
//
//  Created by Steve Baker on 12/31/15.
//  Copyright © 2015 Beepscore LLC. All rights reserved.
//

import XCTest
@testable import ShuffleSwift

class BSShufflerTests: XCTestCase {
    
    func testIsNodeIndex0AtEndOfString() {
        let node = BSNode(value:"foo", index0: 2, index1: 0, left: nil, right: nil)
        
        XCTAssertTrue(BSShuffler.isNodeIndex0AtEndOfString(node, string: "abc"))
        XCTAssertTrue(BSShuffler.isNodeIndex0AtEndOfString(node, string: ""))
        
        XCTAssertFalse(BSShuffler.isNodeIndex0AtEndOfString(node, string: "ab"))
        XCTAssertFalse(BSShuffler.isNodeIndex0AtEndOfString(node, string: "abcd"))
    }
    
    func testIsNodeIndex1AtEndOfString() {
        let node = BSNode(value:"foo", index0: 0, index1: 3, left: nil, right: nil)
        
        XCTAssertFalse(BSShuffler.isNodeIndex1AtEndOfString(node, string: "abc"))
        XCTAssertTrue(BSShuffler.isNodeIndex1AtEndOfString(node, string: ""))
        
        XCTAssertFalse(BSShuffler.isNodeIndex1AtEndOfString(node, string: "ab"))
        XCTAssertTrue(BSShuffler.isNodeIndex1AtEndOfString(node, string: "abcd"))
    }

}