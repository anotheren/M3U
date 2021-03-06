//
//  EXTM3U.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/25.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

/// EXTM3U
///
/// The EXTM3U tag indicates that the file is an Extended M3U
/// Playlist file.  It MUST be the first line of every Media Playlist and
/// every Master Playlist.
///
/// >  https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.1.1
///
public struct EXTM3U: Equatable {
    
    public init() { }
}

extension EXTM3U: EXTTag {
    
    public static var hint: String {
        "#EXTM3U"
    }
    
    public init?(lines: [String]) {
        let line = lines[0]
        guard line.hasPrefix(Self.hint) else {
            return nil
        }
        self.init()
    }
    
    public var lines: [String] {
        [Self.hint]
    }
}

extension EXTM3U: CustomStringConvertible {
    
    public var description: String {
        "EXTM3U()"
    }
}
