//
//  EXT-X-BITRATE.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/30.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

public struct EXT_X_BITRATE: Equatable {
    
    public var rate: Int
    
    public init(rate: Int) {
        self.rate = rate
    }
}

extension EXT_X_BITRATE: EXTTag {
    
    public static var hint: String {
        "#EXT-X-BITRATE"
    }
    
    public init?(lines: [String]) {
        let line = lines[0]
        guard line.hasPrefix(Self.hint) else {
            return nil
        }
        let startIndex = line.index(line.startIndex, offsetBy: Self.hint.count+1)
        let endIndex = line.endIndex
        let plainText = line[startIndex..<endIndex]
        guard let rate = Int(plainText) else {
            return nil
        }
        self.init(rate: rate)
    }
    
    public var lines: [String] {
        ["\(Self.hint):\(rate)"]
    }
}

extension EXT_X_BITRATE: CustomStringConvertible {
    
    public var description: String {
        "EXT-X-BITRATE(rate:\(rate)"
    }
}
