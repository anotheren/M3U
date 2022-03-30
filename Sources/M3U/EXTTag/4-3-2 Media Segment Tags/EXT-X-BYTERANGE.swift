//
//  EXT-X-BYTERANGE.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/30.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

public struct EXT_X_BYTERANGE: Equatable {
    
    public var range: EXTByteRange
    
    public init(range: EXTByteRange) {
        self.range = range
    }
}

extension EXT_X_BYTERANGE: EXTTag {
    
    public static var hint: String {
        "#EXT-X-BYTERANGE"
    }
    
    public init?(lines: [String]) {
        let line = lines[0]
        guard line.hasPrefix(Self.hint) else {
            return nil
        }
        let startIndex = line.index(line.startIndex, offsetBy: Self.hint.count+1)
        let endIndex = line.endIndex
        let plainText = String(line[startIndex..<endIndex])
        guard let range = EXTByteRange(string: plainText) else {
            return nil
        }
        self.init(range: range)
    }
    
    public var lines: [String] {
        ["\(Self.hint):\(range)"]
    }
}

extension EXT_X_BYTERANGE: CustomStringConvertible {
    
    public var description: String {
        "EXT-X-BYTERANGE(\(range))"
    }
}
