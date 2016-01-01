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

    func testIsLeafNode() {
        let node = BSNode(value:"a", index0: 0, index1: -1, left: nil, right: nil)
        XCTAssertFalse(BSShuffler.isLeafNode(node, string0:"a", string1:"b"))
    }

    //==========================================================================
    // MARK: - testIsValidShuffleForEdgeCases

    func testIsValidShuffleForEdgeCasesShuffledStringEmpty() {
        
        XCTAssertEqual(BSShuffler.BSShuffleValidityCode.Valid,
            BSShuffler.isValidShuffleForEdgeCases("", string0:"", string1:""))
        
        XCTAssertEqual(BSShuffler.BSShuffleValidityCode.NotValid,
            BSShuffler.isValidShuffleForEdgeCases("", string0:"a", string1:""))
        
        XCTAssertEqual(BSShuffler.BSShuffleValidityCode.NotValid,
            BSShuffler.isValidShuffleForEdgeCases("", string0:"", string1:"xy"))
        
        XCTAssertEqual(BSShuffler.BSShuffleValidityCode.NotValid,
            BSShuffler.isValidShuffleForEdgeCases("", string0:"a", string1:"b"))
    }

    func testIsValidShuffleForEdgeCasesSourceStringEmpty() {
        
        XCTAssertEqual(BSShuffler.BSShuffleValidityCode.Valid,
            BSShuffler.isValidShuffleForEdgeCases("abc", string0:"abc", string1:""))
        
        XCTAssertEqual(BSShuffler.BSShuffleValidityCode.Valid,
            BSShuffler.isValidShuffleForEdgeCases("abc", string0:"", string1:"abc"))
        
        XCTAssertEqual(BSShuffler.BSShuffleValidityCode.NotValid,
            BSShuffler.isValidShuffleForEdgeCases("abc", string0:"", string1:""))
    }

    func testAddRootNodeToQueue() {

        let shuffler = BSShuffler()
        var queue : Array<BSNode> = []

        XCTAssertEqual(0, queue.count)

        //addRootNodeToQueue mutates inout argument queue so must call as &queue
        shuffler.addRootNodeToQueue(&queue)
        XCTAssertEqual(1, queue.count)

        let rootNode : BSNode = queue.last!

        XCTAssertEqual("", rootNode.value)
        XCTAssertEqual(-1, rootNode.index0)
        XCTAssertEqual(-1, rootNode.index1)
        XCTAssertEqual(nil, rootNode.left)
        XCTAssertEqual(nil, rootNode.right)
    }

    func testShuffledStringStart() {
        let node = BSNode()
        let shuffledString = "abc"
        
        XCTAssertEqual("", BSShuffler.shuffledStringStart(shuffledString, node: node))

        node.value = "a"
        XCTAssertEqual(node.value, BSShuffler.shuffledStringStart(shuffledString, node: node))

        node.value = "ab"
        XCTAssertEqual(node.value, BSShuffler.shuffledStringStart(shuffledString, node: node))

        node.value = "abc"
        XCTAssertEqual(node.value, BSShuffler.shuffledStringStart(shuffledString, node: node))
    }

    func testShuffledStringStartNodeValueLongerThanShuffledString() {
        let node = BSNode()
        node.value = "abcdefghijk"
        let shuffledString = "abc"
        XCTAssertEqual(shuffledString, BSShuffler.shuffledStringStart(shuffledString, node: node))
    }

}
