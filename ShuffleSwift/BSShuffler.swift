//
//  BSShuffler.swift
//  ShuffleSwift
//
//  Created by Steve Baker on 12/31/15.
//  Copyright © 2015 Beepscore LLC. All rights reserved.
//

import Foundation

class BSShuffler : NSObject {

    // https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Enumerations.html
    enum BSShuffleValidityCode {
        case Unknown
        case NotValid
        case Valid
    }

    /** Contains values of nodes visited.
     *  Note node values are not guaranteed to be unique.
     *  Useful during development for examining traversal history.
     */
    var nodesSearched: Array<String> = []

    class func isNodeValueEqualToValue(node: BSNode, value: String) -> Bool {
        if (node.value == value) {
            return true
        }
        return false
    }

    // MARK: - node index methods
    
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

    //==========================================================================
    // MARK: -

    /**
    * Checks several edge cases such as arguments empty strings
    * Returns BSShuffleValidityCode instead of boolean (true, false)
    * @param shuffledString
    * @param string0
    * @param string1
    * @return BSShuffleValidityCode.Valid if shuffledString is a valid shuffle
    * of string0 and string1.
    * return BSShuffleValidityCode.NotValid if shuffledString is not a valid shuffle
    * of string0 and string1.
    * return BSShuffleValidityCode.Unknown if method can't tell if shuffledString
    * is a valid shuffle of string0 and string1.
    */
    class func isValidShuffleForEdgeCases(shuffledString: String,
        string0: String,
        string1: String) -> BSShuffleValidityCode {
            
            if (shuffledString == "") {
                if ((string0 == "") && (string1 == "")) {
                        return BSShuffleValidityCode.Valid
                } else {
                    return BSShuffleValidityCode.NotValid
                }
            }
            
            if ((string0 == "") && (string1 == "")) {
                    return BSShuffleValidityCode.NotValid
            }
            
            if ((string0 == "")
                && (string1 == shuffledString)) {
                    return BSShuffleValidityCode.Valid
            }
            
            if ((string1 == "")
                && (string0 == shuffledString)) {
                    return BSShuffleValidityCode.Valid
            }
            return BSShuffleValidityCode.Unknown
    }

    class func isLeafNode(node: BSNode, string0: String, string1: String) -> Bool {

        if (BSStringUtils.isStringEmpty(string0)
        && BSStringUtils.isStringEmpty(string1)) {
            return true
        }

        if (BSStringUtils.isStringEmpty(string0)) {
            if (node.index1 == string1.characters.count - 1) {
                return true
            } else {
                return false
            }
        }

        if (BSStringUtils.isStringEmpty(string1)) {
            if (node.index0 == string0.characters.count - 1) {
                return true
            } else {
                return false
            }
        }
        
        // string0 and string1 are non-empty
        
        if (BSShuffler.isNodeIndex0AtEndOfString(node, string: string0)
            && BSShuffler.isNodeIndex1AtEndOfString(node, string: string1)) {
                return true
        } else {
            return false
        }
    }

    class func isASolution(node: BSNode, shuffledString: String,
        string0: String, string1: String) -> Bool {
            
            if (BSShuffler.isLeafNode(node, string0:string0, string1:string1)
                && BSShuffler.isNodeValueEqualToValue(node, value:shuffledString)) {
                    return true
            } else {
                return false
            }
    }

    //==========================================================================
    // MARK: -
    /**
    * This method has side effect sets self.nodesSearched to empty array.
    * @param queue declared inout so function can mutate it's value
    * caller must use &queue
    */
    func addRootNodeToQueue(inout queue : Array<BSNode>) {
        // this index value signifies node has no letters from that source
        // e.g. if node.index0 == -1, node.value contains no letters from string0
        let indexBeforeSourceStart = -1;
        
        self.nodesSearched = []
        
        // root node has empty value and no letters from either source string
        let rootNode = BSNode(value: "",
            index0: indexBeforeSourceStart,
            index1: indexBeforeSourceStart,
            left: nil, right: nil)
        
        // queue, add to end of array
        queue.append(rootNode)
    }
    
}