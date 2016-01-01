//
//  BSStringUtilsTests.swift
//  ShuffleSwift
//
//  Created by Steve Baker on 12/31/15.
//  Copyright © 2015 Beepscore LLC. All rights reserved.
//

import XCTest
@testable import ShuffleSwift

class BSStringUtilsTests: XCTestCase {

    func testIsStringEmpty () {
        XCTAssertTrue(BSStringUtils.isStringEmpty(""));
        
        XCTAssertFalse(BSStringUtils.isStringEmpty("B"));
    }
    
}
