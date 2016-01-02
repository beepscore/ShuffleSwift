//
//  BSStringUtils.swift
//  ShuffleSwift
//
//  Created by Steve Baker on 12/31/15.
//  Copyright © 2015 Beepscore LLC. All rights reserved.
//

import Foundation

class BSStringUtils : NSObject {

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