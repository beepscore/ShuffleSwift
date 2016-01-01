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

    func testPracticeUsingSwiftSubstringFromIndex () {
        var testString = ""
        XCTAssertEqual(testString, testString.substringFromIndex(testString.startIndex))
        XCTAssertEqual("", testString.substringFromIndex(testString.endIndex))

        testString = "a"
        XCTAssertEqual(testString, testString.substringFromIndex(testString.startIndex))
        XCTAssertEqual("", testString.substringFromIndex(testString.startIndex.advancedBy(1)))
        // This crashes with error message - fatal error: can not increment endIndex (sic)
        // XCTAssertEqual("", testString.substringFromIndex(testString.startIndex.advancedBy(2)))

        XCTAssertEqual("", testString.substringFromIndex(testString.endIndex))
        XCTAssertEqual("a", testString.substringFromIndex(testString.endIndex.predecessor()))
        XCTAssertEqual("a", testString.substringFromIndex(testString.endIndex.advancedBy(-1)))
        // This crashes with error message - fatal error: can not decrement startIndex (sic)
        // XCTAssertEqual("a", testString.substringFromIndex(testString.endIndex.advancedBy(-2)))

        testString = "ab"
        XCTAssertEqual(testString, testString.substringFromIndex(testString.startIndex))
        XCTAssertEqual("b", testString.substringFromIndex(testString.startIndex.advancedBy(1)))
        XCTAssertEqual("", testString.substringFromIndex(testString.endIndex))
        XCTAssertEqual("b", testString.substringFromIndex(testString.endIndex.predecessor()))

        testString = "abc"
        XCTAssertEqual("c", testString.substringFromIndex(testString.endIndex.predecessor()))
    }

    func testPracticeUsingSwiftSubstringToIndex () {
        var testString = ""
        XCTAssertEqual(testString, testString.substringToIndex(testString.endIndex))
        testString = "a"
        XCTAssertEqual(testString, testString.substringToIndex(testString.endIndex))
    }

    func testPracticeUsingSwiftSubstringWithRange () {
        var testString = ""
        XCTAssertEqual(testString,
            testString.substringWithRange(testString.startIndex..<testString.endIndex))

        testString = "ab"
        XCTAssertEqual(testString,
            testString.substringWithRange(testString.startIndex..<testString.endIndex))
        
        testString = "abc"
        XCTAssertEqual(testString,
            testString.substringWithRange(testString.startIndex..<testString.endIndex))

        testString = "abcd"
        XCTAssertEqual("bc",
            testString.substringWithRange(testString.startIndex.successor()..<testString.endIndex.predecessor()))
    }

}
