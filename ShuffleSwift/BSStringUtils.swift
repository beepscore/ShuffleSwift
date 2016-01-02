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
        startIndex: String.CharacterView.Index?,
        endIndex: String.CharacterView.Index?) -> String {
            
            var safeStartIndex : String.CharacterView.Index
            var safeEndIndex : String.CharacterView.Index
            
            if (startIndex == nil) {
                safeStartIndex = aString.startIndex
            } else {
                safeStartIndex = startIndex!
            }
            
            if ((endIndex == nil)
                || (endIndex > aString.endIndex)) {
                    safeEndIndex = aString.endIndex
            } else {
                safeEndIndex = endIndex!
            }
            
            let range = safeStartIndex..<safeEndIndex
            let substring = aString[range]
            return substring
    }

    /** Method is "safe" in that it avoids out of bounds exceptions
     * @param string
     * @param index may be nil, at start, in middle, at end, or past end of string.
     * @return empty string if index is nil or at endIndex or past end of string.
     * return first character if index is aString.startIndex
     * return last character if index is aString.endIndex.predecessor()
     */
    class func safeCharacterFromString(string: String,
        index: String.CharacterView.Index?) -> String {
            
            if ((index == nil)
                || (index >= string.endIndex)) {
                    return ""
            }
            
            let range = index!..<index!.successor()
            let characterString = string[range]
            return characterString
    }

}