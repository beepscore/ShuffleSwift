//
//  BSNode.swift
//  ShuffleSwift
//
//  Created by Steve Baker on 12/28/15.
//  Copyright © 2015 Beepscore LLC. All rights reserved.
//

import Foundation

class BSNode : NSObject {

    /** The partial shuffledString obtained by descending the node tree,
     * drawing the next matching available character from string0 or string1 at each step.
     */
    var value: String = ""

    /** The string0 index.
     *  For example if to reach this node we used the first 3 characters from string0
     *  index0 is 2
     *  nil if we have not used any characters from string0
     */
    var index0: String.Index? = nil

    /** The string1 index.
     *  For example if to reach this node we used the first 7 characters from string1
     *  index1 is 6
     *  nil if we have not used any characters from string1
     */
    var index1: String.Index? = nil

    var left: BSNode? = nil
    var right: BSNode? = nil

    // https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html
    convenience init(value: String, index0: String.Index, index1: String.Index,
        left: BSNode?, right: BSNode?) {
            self.init()
            self.value = value
            self.index0 = index0
            self.index1 = index1
            self.left = left
            self.right = right
    }

    override var description : String {
        
        let SEPARATOR_SPACE = ", "
//        var index0String = ""
//        var index1String = ""
        var leftString = ""
        var rightString = ""
        
        //index0String = self.index0!description
        //index1String = self.index1!description
        
        if (self.left == nil) {
            leftString = "left: nil"
        } else {
            leftString = "left.value: " + self.left!.value
        }
        if (self.right == nil) {
            rightString = "right: nil"
        } else {
            rightString = "right.value: " + self.right!.value
        }
        
        let descriptionString = value + SEPARATOR_SPACE
//            + index0String + SEPARATOR_SPACE
//            + index1String + SEPARATOR_SPACE
            + leftString + SEPARATOR_SPACE
            + rightString
        
        return descriptionString
    }

}
