//
//  EXT-X-MEDIA-SEQUENCE.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/30.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

/// EXT-X-MEDIA-SEQUENCE
///
/// The EXT-X-MEDIA-SEQUENCE tag indicates the Media Sequence Number of
/// the first Media Segment that appears in a Playlist file.
///
/// > https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.3.2
///
public struct EXT_X_MEDIA_SEQUENCE: Equatable {
    
    public var sequence: Int
    
    public init(sequence: Int) {
        self.sequence = sequence
    }
}

extension EXT_X_MEDIA_SEQUENCE: EXTTag {
    
    public static var hint: String {
        "#EXT-X-MEDIA-SEQUENCE"
    }
    
    public init?(lines: [String]) {
        let line = lines[0]
        guard line.hasPrefix(Self.hint) else {
            return nil
        }
        let startIndex = line.index(line.startIndex, offsetBy: Self.hint.count+1)
        let endIndex = line.endIndex
        let plainText = String(line[startIndex..<endIndex])
        guard let sequence = Int(plainText) else {
            return nil
        }
        self.init(sequence: sequence)
    }
    
    public var lines: [String] {
        ["\(Self.hint):\(sequence)"]
    }
}

extension EXT_X_MEDIA_SEQUENCE: CustomStringConvertible {
    
    public var description: String {
        "EXT-X-MEDIA-SEQUENCE(SEQUENCE:\(sequence))"
    }
}
