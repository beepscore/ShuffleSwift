//
//  ShufflerTests.swift
//  ShuffleSwift
//
//  Created by Steve Baker on 12/31/15.
//  Copyright © 2015 Beepscore LLC. All rights reserved.
//

import XCTest
@testable import ShuffleSwift

class ShufflerTests: XCTestCase {
    
    func testIsNodeIndex0AtEndOfString() {
        let node = Node()

        var string = ""
        node.index0 = string.endIndex
        XCTAssertTrue(Shuffler.isNodeIndex0AtEndOfString(node, string: string))

        string = "abc"
        node.index0 = string.endIndex
        XCTAssertTrue(Shuffler.isNodeIndex0AtEndOfString(node, string: string))

        string = "abc"
        node.index0 = string.endIndex.predecessor()
        XCTAssertFalse(Shuffler.isNodeIndex0AtEndOfString(node, string: string))
    }
    
    func testIsNodeIndex1AtEndOfString() {
        let node = Node()

        var string = ""
        node.index1 = string.endIndex
        XCTAssertTrue(Shuffler.isNodeIndex1AtEndOfString(node, string: string))

        string = "abc"
        node.index1 = string.endIndex
        XCTAssertTrue(Shuffler.isNodeIndex1AtEndOfString(node, string: string))

        string = "abc"
        node.index1 = string.endIndex.predecessor()
        XCTAssertFalse(Shuffler.isNodeIndex1AtEndOfString(node, string: string))
    }

    func testIsLeafNode() {
        let node = Node()
        let string0 = "moe"
        let string1 = "curly"
        node.index0 = string0.endIndex
        node.index1 = string1.startIndex.advancedBy(1)

        XCTAssertFalse(Shuffler.isLeafNode(node, string0:string0, string1:string1))
    }

    //==========================================================================
    // MARK: - testIsValidShuffleForEdgeCases

    func testIsValidShuffleForEdgeCasesShuffledStringEmpty() {
        
        XCTAssertEqual(Shuffler.BSShuffleValidityCode.Valid,
            Shuffler.isValidShuffleForEdgeCases("", string0:"", string1:""))
        
        XCTAssertEqual(Shuffler.BSShuffleValidityCode.NotValid,
            Shuffler.isValidShuffleForEdgeCases("", string0:"a", string1:""))
        
        XCTAssertEqual(Shuffler.BSShuffleValidityCode.NotValid,
            Shuffler.isValidShuffleForEdgeCases("", string0:"", string1:"xy"))
        
        XCTAssertEqual(Shuffler.BSShuffleValidityCode.NotValid,
            Shuffler.isValidShuffleForEdgeCases("", string0:"a", string1:"b"))
    }

    func testIsValidShuffleForEdgeCasesSourceStringEmpty() {
        
        XCTAssertEqual(Shuffler.BSShuffleValidityCode.Valid,
            Shuffler.isValidShuffleForEdgeCases("abc", string0:"abc", string1:""))
        
        XCTAssertEqual(Shuffler.BSShuffleValidityCode.Valid,
            Shuffler.isValidShuffleForEdgeCases("abc", string0:"", string1:"abc"))
        
        XCTAssertEqual(Shuffler.BSShuffleValidityCode.NotValid,
            Shuffler.isValidShuffleForEdgeCases("abc", string0:"", string1:""))
    }

    //==========================================================================
    // MARK: - testIsValidShuffle

    func testIsValidShuffleShuffledStringEmpty() {
        let shuffler = Shuffler()
        
        XCTAssertTrue(shuffler.isValidShuffle("", string0: "", string1: ""))

        // TODO: Consider changing method to return true for these edge cases
        XCTAssertFalse(shuffler.isValidShuffle("", string0: "a", string1: ""))
        XCTAssertFalse(shuffler.isValidShuffle("", string0: "", string1: "xy"))
        XCTAssertFalse(shuffler.isValidShuffle("", string0: "a", string1: "b"))
    }

    func testIsValidShuffleSourceStringEmpty() {
        let shuffler = Shuffler()

        XCTAssertFalse(shuffler.isValidShuffle("abc", string0: "", string1: ""))
        XCTAssertTrue(shuffler.isValidShuffle("abc", string0: "abc", string1: ""))
        XCTAssertTrue(shuffler.isValidShuffle("abc", string0: "", string1: "abc"))
    }

    func testIsValidShuffle() {
        let shuffler = Shuffler()

        XCTAssertTrue(shuffler.isValidShuffle("ab", string0: "a", string1: "b"))
        XCTAssertFalse(shuffler.isValidShuffle("abc", string0: "a", string1: "b"))
        XCTAssertTrue(shuffler.isValidShuffle("dabecf", string0: "abc", string1: "def"))
        XCTAssertTrue(shuffler.isValidShuffle("abcdefghijkl", string0: "abcghi", string1: "defjkl"))
        XCTAssertFalse(shuffler.isValidShuffle("abcdefghijkl", string0: "abchgi", string1: "defjkl"))
    }

    func testIsValidShuffleLettersInCommon() {
        let shuffler = Shuffler()
        
        // string0 and string1 contain letters in common
        XCTAssertTrue(shuffler.isValidShuffle("abca", string0: "ac", string1: "ba"))
        XCTAssertTrue(shuffler.isValidShuffle("acbbca", string0: "abc", string1: "cba"))
        XCTAssertTrue(shuffler.isValidShuffle("abaabza", string0: "aba", string1: "abza"))
        XCTAssertTrue(shuffler.isValidShuffle("This is a great day indeed!",
            string0: "T reayde", string1: "hisis a gt da ined!"))

        // expect false because strings are case sensitive
        XCTAssertFalse(shuffler.isValidShuffle("This is a great day indeed!",
            string0: "t reayde", string1: "hisis a gt da ined!"))
    }

    func testIsValidShuffleUTF8() {
        let shuffler = Shuffler()
        
        // Chinese from http://www.foxconn.com/index.html
        XCTAssertTrue(shuffler.isValidShuffle("公告本公司董事會通過104年第一季合併",
            string0: "公司會0合",
            string1: "告本公董事通過14年第一季併"))
        
        XCTAssertFalse(shuffler.isValidShuffle("公告本公司董事會通過104年第一季合併",
            string0: "公司0合",
            string1: "會告本公董事通過14年第一季併"))
    }

    //==========================================================================
    // MARK: -

    func testAddRootNodeToQueue() {

        let shuffler = Shuffler()
        var queue: [Node] = []

        XCTAssertEqual(0, queue.count)

        //addRootNodeToQueue mutates inout argument queue so must call as &queue
        shuffler.addRootNodeToQueue(&queue)
        XCTAssertEqual(1, queue.count)

        let rootNode: Node = queue.last!

        XCTAssertEqual("", rootNode.value)
        XCTAssertNil(rootNode.index0)
        XCTAssertNil(rootNode.index1)
        XCTAssertEqual(nil, rootNode.left)
        XCTAssertEqual(nil, rootNode.right)
    }

    func testShuffledStringStart() {
        let node = Node()
        let shuffledString = "abc"
        
        XCTAssertEqual("", Shuffler.shuffledStringStart(shuffledString, node: node))

        node.value = "a"
        XCTAssertEqual(node.value, Shuffler.shuffledStringStart(shuffledString, node: node))

        node.value = "ab"
        XCTAssertEqual(node.value, Shuffler.shuffledStringStart(shuffledString, node: node))

        node.value = "abc"
        XCTAssertEqual(node.value, Shuffler.shuffledStringStart(shuffledString, node: node))
    }

    func testShuffledStringStartNodeValueLongerThanShuffledString() {
        let node = Node()
        node.value = "abcdefghijk"
        let shuffledString = "abc"
        XCTAssertEqual(shuffledString, Shuffler.shuffledStringStart(shuffledString, node: node))
    }

    func testAddLeftNodeToNodeAndQueue() {
        let shuffler = Shuffler()
        var queue: [Node] = []

        //addRootNodeToQueue mutates inout argument queue so must call as &queue
        shuffler.addRootNodeToQueue(&queue)
        let rootNode: Node = queue.last!

        XCTAssertEqual("", rootNode.value)
        XCTAssertNil(rootNode.index0)
        XCTAssertNil(rootNode.index1)
        XCTAssertEqual(nil, rootNode.left)
        XCTAssertEqual(nil, rootNode.right)

        let string0 = "abc"

        XCTAssertEqual(1, queue.count)

        //addLeftNodeToNodeAndQueue mutates inout argument queue so must call as &queue
        Shuffler.addLeftNodeToNodeAndQueue(rootNode, queue: &queue, string0: string0)

        XCTAssertEqual(2, queue.count)
        XCTAssertEqual(rootNode, queue.first!)
        let leftNode: Node = queue.last!
        XCTAssertEqual(leftNode, rootNode.left)
        XCTAssertEqual(nil, rootNode.right)
        XCTAssertEqual("a", leftNode.value)
        XCTAssertEqual(string0.startIndex, leftNode.index0)
    }

    func testAddRightNodeToNodeAndQueue() {
        let shuffler = Shuffler()
        var queue: [Node] = []

        //addRootNodeToQueue mutates inout argument queue so must call as &queue
        shuffler.addRootNodeToQueue(&queue)
        let rootNode: Node = queue.last!

        XCTAssertEqual("", rootNode.value)
        XCTAssertNil(rootNode.index0)
        XCTAssertNil(rootNode.index1)
        XCTAssertEqual(nil, rootNode.left)
        XCTAssertEqual(nil, rootNode.right)

        let string1 = "abc"

        XCTAssertEqual(1, queue.count)

        //addRightNodeToNodeAndQueue mutates inout argument queue so must call as &queue
        Shuffler.addRightNodeToNodeAndQueue(rootNode, queue: &queue, string1: string1)

        XCTAssertEqual(2, queue.count)
        XCTAssertEqual(rootNode, queue.first!)
        let rightNode: Node = queue.last!
        XCTAssertEqual(rightNode, rootNode.right)
        XCTAssertEqual(nil, rootNode.left)
        XCTAssertEqual("a", rightNode.value)
        XCTAssertEqual(string1.startIndex, rightNode.index1)
    }

}
