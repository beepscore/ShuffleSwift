//
//  BSNodeTests.swift
//  ShuffleSwift
//
//  Created by Steve Baker on 12/28/15.
//  Copyright © 2015 Beepscore LLC. All rights reserved.
//

import XCTest
@testable import ShuffleSwift

class BSNodeTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testDefaults() {
        let node = BSNode()
        XCTAssertEqual(nil, node.value)
        XCTAssertEqual(0, node.index0)
        XCTAssertEqual(0, node.index1)
        XCTAssertEqual(nil, node.left)
        XCTAssertEqual(nil, node.right)
    }

    func testConvenienceInitializer() {
        // Setup
        // Use default initializer to instantiate child nodes for use as arguments
        let larry = BSNode()
        larry.value = "Larry"
        XCTAssertEqual("Larry", larry.value)

        let rick = BSNode()
        rick.value = "Rick"
        XCTAssertEqual("Rick", rick.value)

        // method under test - convenience initializer
        let joe = BSNode.init(value: "Joe", index0: 4, index1: 2, left: larry, right: rick)
        XCTAssertEqual("Joe", joe.value)
        XCTAssertEqual(4, joe.index0)
        XCTAssertEqual(2, joe.index1)
        XCTAssertEqual(larry, joe.left)
        XCTAssertEqual(rick, joe.right)

    }
}
