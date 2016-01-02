//
//  BSStringUtils.swift
//  ShuffleSwift
//
//  Created by Steve Baker on 12/31/15.
//  Copyright © 2015 Beepscore LLC. All rights reserved.
//

import Foundation

class BSStringUtils : NSObject {

    /**
     *  TODO: Consider deleting this method after app is ported.
     *  In Swift it is very simple and may not be worthwhile.
     */
    class func isStringEmpty(string: String) -> Bool {
        if (string == "") {
            return true
        } else {
            return false
        }
    }

    /** Method is "safe" in that it avoids out of bounds exceptions
     * This method may not be as useful for Swift String as it was for Objective C NSString
     * range from startIndex to endIndex is inclusive.
     * Inclusive range is like Swift String but unlike NSString substringWithRange.
     * @param aString
     * @param endIndex may be in middle, at end, or past end of aString.
     * @param startIndex
     * @return substring from startIndex to endIndex inclusive.
     *         return substring to endIndex if endIndex >= aString.characters.count
     */
     // TODO: Consider refactor/rename to more idiomatic Swift.
     // For example can change parameters from startIndex, endIndex to a range.
    class func safeSubstringInclusive(aString: String,
        startIndex: String.CharacterView.Index,
        endIndex: String.CharacterView.Index) -> String {
            var substring = ""
            if (endIndex >= aString.endIndex) {
                // endIndex is at or past end of aString
                substring = aString.substringFromIndex(startIndex)
            } else {
                let range = startIndex...endIndex
                substring = aString[range]
            }
            return substring
    }

}