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
        let node = BSNode()

        var string = ""
        node.index0 = string.endIndex
        XCTAssertTrue(BSShuffler.isNodeIndex0AtEndOfString(node, string: string))

        string = "abc"
        node.index0 = string.endIndex
        XCTAssertTrue(BSShuffler.isNodeIndex0AtEndOfString(node, string: string))

        string = "abc"
        node.index0 = string.endIndex.predecessor()
        XCTAssertFalse(BSShuffler.isNodeIndex0AtEndOfString(node, string: string))
    }
    
    func testIsNodeIndex1AtEndOfString() {
        let node = BSNode()

        var string = ""
        node.index1 = string.endIndex
        XCTAssertTrue(BSShuffler.isNodeIndex1AtEndOfString(node, string: string))

        string = "abc"
        node.index1 = string.endIndex
        XCTAssertTrue(BSShuffler.isNodeIndex1AtEndOfString(node, string: string))

        string = "abc"
        node.index1 = string.endIndex.predecessor()
        XCTAssertFalse(BSShuffler.isNodeIndex1AtEndOfString(node, string: string))
    }

    func testIsLeafNode() {
        let node = BSNode()
        let string0 = "moe"
        let string1 = "curly"
        node.index0 = string0.endIndex
        node.index1 = string1.startIndex.advancedBy(1)

        XCTAssertFalse(BSShuffler.isLeafNode(node, string0:string0, string1:string1))
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
        XCTAssertNil(rootNode.index0)
        XCTAssertNil(rootNode.index1)
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

    func testAddLeftNodeToNodeAndQueue() {
        let shuffler = BSShuffler()
        var queue : Array<BSNode> = []

        //addRootNodeToQueue mutates inout argument queue so must call as &queue
        shuffler.addRootNodeToQueue(&queue)
        let rootNode : BSNode = queue.last!

        XCTAssertEqual("", rootNode.value)
        XCTAssertNil(rootNode.index0)
        XCTAssertNil(rootNode.index1)
        XCTAssertEqual(nil, rootNode.left)
        XCTAssertEqual(nil, rootNode.right)

        let string0 = "abc"

        XCTAssertEqual(1, queue.count)

        //addLeftNodeToNodeAndQueue mutates inout argument queue so must call as &queue
        shuffler.addLeftNodeToNodeAndQueue(rootNode, queue: &queue, string0: string0)

        XCTAssertEqual(2, queue.count)
        XCTAssertEqual(rootNode, queue.first!)
        let leftNode : BSNode = queue.last!
        XCTAssertEqual(leftNode, rootNode.left)
        XCTAssertEqual(nil, rootNode.right)
        XCTAssertEqual("a", leftNode.value)
        XCTAssertEqual(string0.startIndex, leftNode.index0)
    }

    func testAddRightNodeToNodeAndQueue() {
        let shuffler = BSShuffler()
        var queue : Array<BSNode> = []

        //addRootNodeToQueue mutates inout argument queue so must call as &queue
        shuffler.addRootNodeToQueue(&queue)
        let rootNode : BSNode = queue.last!

        XCTAssertEqual("", rootNode.value)
        XCTAssertNil(rootNode.index0)
        XCTAssertNil(rootNode.index1)
        XCTAssertEqual(nil, rootNode.left)
        XCTAssertEqual(nil, rootNode.right)

        let string1 = "abc"

        XCTAssertEqual(1, queue.count)

        //addRightNodeToNodeAndQueue mutates inout argument queue so must call as &queue
        shuffler.addRightNodeToNodeAndQueue(rootNode, queue: &queue, string1: string1)

        XCTAssertEqual(2, queue.count)
        XCTAssertEqual(rootNode, queue.first!)
        let rightNode : BSNode = queue.last!
        XCTAssertEqual(rightNode, rootNode.right)
        XCTAssertEqual(nil, rootNode.left)
        XCTAssertEqual("a", rightNode.value)
        XCTAssertEqual(string1.startIndex, rightNode.index1)
    }

}
