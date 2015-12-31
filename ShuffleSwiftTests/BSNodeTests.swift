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

}
