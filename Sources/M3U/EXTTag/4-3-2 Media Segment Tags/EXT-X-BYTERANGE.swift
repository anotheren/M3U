//
//  EXT-X-BYTERANGE.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/30.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

/// EXT-X-BYTERANGE
///
/// The EXT-X-BYTERANGE tag indicates that a Media Segment is a sub-range
/// of the resource identified by its URI.  It applies only to the next
/// URI line that follows it in the Playlist.
///
/// > https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.2.2
///
public struct EXT_X_BYTERANGE: Equatable {
    
    public var range: EXTByterange
    
    public init(range: EXTByterange) {
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
        guard let range = EXTByterange(string: plainText) else {
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
