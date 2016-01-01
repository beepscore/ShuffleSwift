//
//  BSShuffler.swift
//  ShuffleSwift
//
//  Created by Steve Baker on 12/31/15.
//  Copyright © 2015 Beepscore LLC. All rights reserved.
//

import Foundation

class BSShuffler : NSObject {
    
    class func isNodeValueEqualToValue(node: BSNode, value: String) -> Bool {
        if (node.value == value) {
            return true
        }
        return false
    }
    
    class func isNodeIndex0AtEndOfString(node: BSNode, string: String) -> Bool {
        return isNodeIndexAtEndOfString(node, index: node.index0!, string: string)
    }
    
    class func isNodeIndex1AtEndOfString(node: BSNode, string: String) -> Bool {
        return isNodeIndexAtEndOfString(node, index: node.index1!, string: string)
    }
    
    class func isNodeIndexAtEndOfString(node: BSNode, index: Int, string: String) -> Bool {
        if (string == "") {
            return true
        }
        if (index == string.characters.count - 1) {
            return true
        } else {
            return false
        }
    }
    
}