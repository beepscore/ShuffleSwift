//
//  BSNode.swift
//  ShuffleSwift
//
//  Created by Steve Baker on 12/28/15.
//  Copyright © 2015 Beepscore LLC. All rights reserved.
//

import Foundation

class BSNode : NSObject {

    var value: String? = nil
    var index0: Int? = 0
    var index1: Int? = 0
    var left: BSNode? = nil
    var right: BSNode? = nil

    // https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html
    convenience init(value: String, index0: Int, index1: Int,
        left: BSNode?, right: BSNode?) {
            self.init()
            self.value = value
            self.index0 = index0
            self.index1 = index1
            self.left = left
            self.right = right
    }

}

