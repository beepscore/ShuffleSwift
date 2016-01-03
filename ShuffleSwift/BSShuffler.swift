//
//  BSShuffler.swift
//  ShuffleSwift
//
//  Created by Steve Baker on 12/31/15.
//  Copyright © 2015 Beepscore LLC. All rights reserved.
//

import Foundation

class BSShuffler: NSObject {

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
    var nodesSearched: [String] = []

    // MARK: - node index methods
    
    class func isNodeIndex0AtEndOfString(node: Node, string: String) -> Bool {
        if (node.index0 == nil) {
            return false
        } else {
            return isIndexAtEndOfString(node.index0!, string: string)
        }
    }
    
    class func isNodeIndex1AtEndOfString(node: Node, string: String) -> Bool {
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

    class func isLeafNode(node: Node, string0: String, string1: String) -> Bool {

        if ((string0 == "") && (string1 == "")) {
            return true
        }

        if (string0 == "") {
            if (node.index1 == string1.endIndex) {
                return true
            } else {
                return false
            }
        }

        if (string1 == "") {
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

    class func isASolution(node: Node, shuffledString: String,
        string0: String, string1: String) -> Bool {
            
            if (BSShuffler.isLeafNode(node, string0:string0, string1:string1)
                && (node.value == shuffledString)) {
                    return true
            } else {
                return false
            }
    }
    
    //==========================================================================
    // MARK: -
    
    /**
    *  shuffledString is valid if it can be formed by interleaving
    *  the characters of string0 and string1 in a way that maintains
    *  the left to right ordering of the characters from each string.
    *
    *  Example:
    *  true == BSShuffler.isValidShuffle("dabecf",
    *                           string0:"abc", string1:"def")
    * Traverses binary tree breadth first.
    * Uses a queue instead of recursion to reduce risk of call stack overflow.
    * @param shuffledString a potential shuffle of string0 and string1
    * @param string0 a source string
    * @param string1 a source string
    * @return true if shuffledString is a valid shuffle of string0 and string1
    * else return false
    */
    func isValidShuffle(shuffledString: String,
        string0: String, string1: String) -> Bool {
            
            let shuffleValidityCode = BSShuffler.isValidShuffleForEdgeCases(shuffledString,
                string0:string0, string1:string1)

            // Swift switch cases do not "fall through", unlike Objective C which needs break
            // https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ControlFlow.html
            switch (shuffleValidityCode) {
            case BSShuffleValidityCode.NotValid:
                return false
            case BSShuffleValidityCode.Valid:
                return true
            case BSShuffleValidityCode.Unknown:
                // edge cases could not determine if shuffle is valid, don't return yet
                break
            }
            
            // TODO: Consider create queue class that wraps Array
            // to implement strict fifo queue
            var queue: [Node] = []
            
            self.addRootNodeToQueue(&queue)
            
            while (queue.count > 0) {
                
                // queue - remove from beginning of array
                // queue.count > 0 so safe to force unwrap
                let node = queue.first!
                queue.removeFirst()
                
                self.nodesSearched.append(node.value)
                
                if (BSShuffler.isLeafNode(node, string0:string0, string1:string1)) {
                    // node is a terminal node
                    if (BSShuffler.isASolution(node,
                        shuffledString:shuffledString,
                        string0:string0,
                        string1:string1)) {
                            return true
                    } else {
                        // skip to next iteration, next node in queue
                        continue
                    }
                }
                
                let shuffledStringStart = BSShuffler.shuffledStringStart(shuffledString,
                    node:node)
                
                if (node.value == shuffledStringStart) {
                    // path to this node is a valid candidate, so add sub-branches
                    BSShuffler.addLeftNodeToNodeAndQueue(node, queue:&queue, string0:string0)
                    BSShuffler.addRightNodeToNodeAndQueue(node, queue:&queue, string1:string1)
                }
            }
            
            // didn't find a solution
            return false
            
    }

    //==========================================================================
    // MARK: -

    /**
    * This method has side effect sets self.nodesSearched to empty array.
    * @param queue declared inout so function can mutate it's value
    * caller must use &queue
    */
    func addRootNodeToQueue(inout queue: [Node]) {

        self.nodesSearched = []
        
        // root node has empty value and no letters from either source string
        let rootNode = Node()

        // queue, add to end of array
        queue.append(rootNode)
    }

    /** 
     * @return start of shuffledString, length equal to node value length
     * return shuffledString if node value is longer than shuffledString
     */
    class func shuffledStringStart(shuffledString: String, node: Node) -> String {
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
    class func addLeftNodeToNodeAndQueue(node: Node, inout queue: [Node], string0: String) {
        
        var nodeLeftIndex0: String.Index;

        if (node.index0 == nil) {
            nodeLeftIndex0 = string0.startIndex
        } else {
            if (node.index0! >= string0.endIndex) {
                // avoid fatal error cannot increment endIndex
                return
            } else {
                nodeLeftIndex0 = node.index0!.successor()
            }
        }

        // get a string of one character
        let nodeLeftNextCharacter = BSStringUtils.safeCharacterFromString(string0, index: nodeLeftIndex0)

        // node.value.append() gave error "ambiguous reference to member 'append'"
        // let nodeLeftValue: String = (node.value).append(nodeLeftNextCharacter)
        let nodeLeftValue: String = node.value + nodeLeftNextCharacter
        
        node.left = Node(value: nodeLeftValue,
            index0: nodeLeftIndex0, index1: node.index1,
            left: nil, right: nil)
        
        queue.append(node.left!)
    }

    /**
    * @param queue declared inout so function can mutate it's value
    * caller must use &queue
    */
    class func addRightNodeToNodeAndQueue(node: Node, inout queue: [Node], string1: String) {
        
        var nodeRightIndex1: String.Index;

        if (node.index1 == nil) {
            nodeRightIndex1 = string1.startIndex
        } else {
            if (node.index1! >= string1.endIndex) {
                // avoid fatal error cannot increment endIndex
                return
            } else {
                nodeRightIndex1 = node.index1!.successor()
            }
        }

        // get a string of one character
        let nodeRightNextCharacter = BSStringUtils.safeCharacterFromString(string1, index: nodeRightIndex1)

        // node.value.append() gave error "ambiguous reference to member 'append'"
        // let nodeRightValue: String = (node.value).append(nodeRightNextCharacter)
        let nodeRightValue: String = node.value + nodeRightNextCharacter
        
        node.right = Node(value: nodeRightValue,
            index0: node.index0, index1: nodeRightIndex1,
            left: nil, right: nil)
        
        queue.append(node.right!)
    }

}