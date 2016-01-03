//
//  NodeTests.swift
//  ShuffleSwift
//
//  Created by Steve Baker on 12/28/15.
//  Copyright © 2015 Beepscore LLC. All rights reserved.
//

import XCTest
@testable import ShuffleSwift

class NodeTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testDefaults() {
        let node = Node()
        XCTAssertEqual("", node.value)
        XCTAssertNil(node.index0)
        XCTAssertNil(node.index1)
        XCTAssertEqual(nil, node.left)
        XCTAssertEqual(nil, node.right)
    }

    func testConvenienceInitializer() {
        // Setup

        // example strings, arbitrary but chosen to help convey how a shuffle works
        let string0 = "aceg"
        let string1 = "bdfh"
        //let shuffledString = "abcdefgh"

        let index0 = string0.startIndex.advancedBy(4)
        let index1 = string1.startIndex.advancedBy(2)

        // Use default initializer to instantiate child nodes for use as arguments
        let larry = Node()
        larry.value = "Larry"
        XCTAssertEqual("Larry", larry.value)

        let rick = Node()
        rick.value = "Rick"
        XCTAssertEqual("Rick", rick.value)

        // method under test - convenience initializer
        let joe = Node.init(value: "abcde",
            index0: index0,
            index1: index1,
            left: larry, right: rick)
        
        XCTAssertEqual("abcde", joe.value)
        XCTAssertEqual(string0.startIndex.advancedBy(4), joe.index0)
        XCTAssertEqual(string1.startIndex.advancedBy(2), joe.index1)
        XCTAssertEqual(larry, joe.left)
        XCTAssertEqual(rick, joe.right)
    }

    func testNodeDescriptionDefaults() {
        let node = Node()
        let expected = ", nil, nil, left: nil, right: nil"
        XCTAssertEqual(expected, node.description)
    }

    func testNodeDescription() {
        // Setup

        // example strings, arbitrary but chosen to help convey how a shuffle works
        let string0 = "aceg"
        let string1 = "bdfh"
        //let shuffledString = "abcdefgh"

        let index0 = string0.startIndex.advancedBy(4)
        let index1 = string1.startIndex.advancedBy(2)

        // Use default initializer to instantiate child nodes for use as arguments
        let larry = Node()
        larry.value = "Larry"
        XCTAssertEqual("Larry", larry.value)

        let rick = Node()
        rick.value = "Rick"
        XCTAssertEqual("Rick", rick.value)

        let joe = Node.init(value: "abcde",
            index0: index0,
            index1: index1,
            left: larry, right: rick)

        let expected = "abcde, 4, 2, left.value: Larry, right.value: Rick"
        XCTAssertEqual(expected, joe.description)
    }
}
