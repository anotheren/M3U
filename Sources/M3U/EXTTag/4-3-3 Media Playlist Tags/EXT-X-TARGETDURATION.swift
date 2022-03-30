//
//  EXT-X-TARGETDURATION.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/30.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

/// EXT-X-TARGETDURATION
///
/// The EXT-X-TARGETDURATION tag specifies the maximum Media Segment
/// duration.  The EXTINF duration of each Media Segment in the Playlist
/// file, when rounded to the nearest integer, MUST be less than or equal
/// to the target duration; longer segments can trigger playback stalls
/// or other errors.  It applies to the entire Playlist file.
///
/// > https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.3.1
///
public struct EXT_X_TARGETDURATION: Equatable {
    
    public var seconds: Int
    
    public init(seconds: Int) {
        self.seconds = seconds
    }
}

extension EXT_X_TARGETDURATION: EXTTag {
    
    public static var hint: String {
        "#EXT-X-TARGETDURATION"
    }
    
    public init?(lines: [String]) {
        let line = lines[0]
        guard line.hasPrefix(Self.hint) else {
            return nil
        }
        let startIndex = line.index(line.startIndex, offsetBy: Self.hint.count+1)
        let endIndex = line.endIndex
        let plainText = String(line[startIndex..<endIndex])
        guard let seconds = Int(plainText) else {
            return nil
        }
        self.init(seconds: seconds)
    }
    
    public var lines: [String] {
        ["\(Self.hint):\(seconds)"]
    }
}

extension EXT_X_TARGETDURATION: CustomStringConvertible {
    
    public var description: String {
        "EXT-X-TARGETDURATION(seconds:\(seconds))"
    }
}
