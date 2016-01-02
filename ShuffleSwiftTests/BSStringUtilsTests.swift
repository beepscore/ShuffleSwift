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

    // MARK: - Practice using Swift String methods. Not designed to "test" Apple's code.

    func testPracticeUsingSwiftSubstringFromIndex() {
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

    func testPracticeUsingSwiftSubstringToIndex() {
        var testString = ""
        XCTAssertEqual(testString, testString.substringToIndex(testString.endIndex))
        testString = "a"
        XCTAssertEqual(testString, testString.substringToIndex(testString.endIndex))
    }

    func testPracticeUsingSwiftSubstringWithRange() {
        var testString = ""
        var range = testString.startIndex..<testString.endIndex
        XCTAssertEqual(testString, testString.substringWithRange(range))
        
        testString = "ab"
        range = testString.startIndex..<testString.endIndex
        XCTAssertEqual(testString, testString.substringWithRange(range))
        
        testString = "abc"
        range = testString.startIndex..<testString.endIndex
        XCTAssertEqual(testString, testString.substringWithRange(range))

        testString = "abcd"
        range = testString.startIndex.successor()..<testString.endIndex.predecessor()
        XCTAssertEqual("bc", testString.substringWithRange(range))

        testString = "abcd"
        range = testString.startIndex..<testString.startIndex
        XCTAssertEqual("", testString.substringWithRange(range))

        testString = "abcd"
        range = testString.startIndex..<testString.startIndex.successor()
        XCTAssertEqual("a", testString.substringWithRange(range))

        testString = "abcd"
        range = testString.startIndex.advancedBy(1)..<testString.startIndex.advancedBy(2)
        XCTAssertEqual("b", testString.substringWithRange(range))
    }

    // MARK: - testSafeCharacterFromString

    func testSafeCharacterFromStringEmpty() {
        let testString = ""
        XCTAssertEqual(testString,
            BSStringUtils.safeCharacterFromString(testString, index:testString.startIndex))
    }

    func testSafeCharacterFromStringIndexNil() {
        XCTAssertEqual("",
            BSStringUtils.safeCharacterFromString("abcd", index:nil))
    }

    func testSafeCharacterFromString() {
        var testString = "abcd"
        XCTAssertEqual("a",
            BSStringUtils.safeCharacterFromString(testString, index:testString.startIndex))

        testString = "abcd"
        XCTAssertEqual("b",
            BSStringUtils.safeCharacterFromString(testString, index:testString.startIndex.successor()))

        testString = "abcd"
        XCTAssertEqual("d",
            BSStringUtils.safeCharacterFromString(testString, index:testString.endIndex.predecessor()))

        testString = "abcd"
        XCTAssertEqual("",
            BSStringUtils.safeCharacterFromString(testString, index:testString.endIndex))
    }

}
