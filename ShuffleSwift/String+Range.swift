//
//  String+Range.swift
//  ShuffleSwift
//
//  Created by Steve Baker on 1/1/16.
//  Copyright © 2016 Beepscore LLC. All rights reserved.
//

// http://stackoverflow.com/questions/26319660/whats-the-best-practice-for-naming-swift-files-that-add-extensions-to-existing

import Foundation

extension String {

    // Converts a regular range (0..5) to a proper String.Index range.
    // https://www.snip2code.com/Snippet/152335/Swift-Convert-Range-Int--to-Range-String
    public func stringIndexRangeFromIntRange(range: Range<Int>) -> Range<String.Index> {
        let startIndex = self.startIndex.advancedBy(range.startIndex)
        let endIndex = self.startIndex.advancedBy(range.endIndex - range.startIndex)
        return Range<String.Index>(start: startIndex, end: endIndex)
    }

    // http://stackoverflow.com/questions/24029163/finding-index-of-character-in-swift-string
    public func indexOfCharacter(char: Character) -> Int? {
        if let idx = self.characters.indexOf(char) {
            return self.startIndex.distanceTo(idx)
        }
        return nil
    }

}
