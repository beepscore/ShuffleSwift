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
        if (node.index0 == nil) {
            return false
        } else {
            return isIndexAtEndOfString(node.index0!, string: string)
        }
    }
    
    class func isNodeIndex1AtEndOfString(node: BSNode, string: String) -> Bool {
        if (node.index1 == nil) {
            return false
        } else {
            return isIndexAtEndOfString(node.index1!, string: string)
        }
    }
    
    class func isIndexAtEndOfString(index: String.Index, string: String) -> Bool {
        if (string == "") {
            return true
        }
        if (index >= string.endIndex) {
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
            if (node.index1 == string1.endIndex) {
                return true
            } else {
                return false
            }
        }

        if (BSStringUtils.isStringEmpty(string1)) {
            if (node.index0 == string0.endIndex) {
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

        self.nodesSearched = []
        
        // root node has empty value and no letters from either source string
        let rootNode = BSNode()

        // queue, add to end of array
        queue.append(rootNode)
    }

    /** 
     * @return start of shuffledString, length equal to node value length
     * return shuffledString if node value is longer than shuffledString
     */
    class func shuffledStringStart(shuffledString: String, node: BSNode) -> String {
        if (node.value.endIndex > shuffledString.endIndex) {
            // avoid index out of range
            return shuffledString
        } else {
            return shuffledString.substringToIndex(node.value.endIndex)
        }
    }

    /**
    * @param queue declared inout so function can mutate it's value
    * caller must use &queue
    */
    func addLeftNodeToNodeAndQueue(node: BSNode, inout queue: Array<BSNode>, string0: String) {
        
        var nodeLeftIndex0 : String.Index;

        if (node.index0 == nil) {
            nodeLeftIndex0 = string0.startIndex
        } else {
            nodeLeftIndex0 = node.index0!.successor()
        }

        // get a string of one character
        let nodeLeftNextCharacter = BSStringUtils.safeCharacterFromString(string0, index: nodeLeftIndex0)

        // node.value.append() gave error "ambiguous reference to member 'append'"
        // let nodeLeftValue : String = (node.value).append(nodeLeftNextCharacter)
        let nodeLeftValue : String = node.value + nodeLeftNextCharacter
        
        node.left = BSNode(value: nodeLeftValue,
            index0: nodeLeftIndex0, index1: node.index1,
            left: nil, right: nil)
        
        queue.append(node.left!)
    }

}