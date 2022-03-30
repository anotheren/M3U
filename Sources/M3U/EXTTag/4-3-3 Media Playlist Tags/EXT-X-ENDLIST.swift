//
//  EXT-X-ENDLIST.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/30.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

/// EXT-X-ENDLIST
///
/// The EXT-X-ENDLIST tag indicates that no more Media Segments will be
/// added to the Media Playlist file.  It MAY occur anywhere in the Media
/// Playlist file.
///
/// > https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.3.4

public struct EXT_X_ENDLIST: Equatable {
    
    public init() { }
}

extension EXT_X_ENDLIST: EXTTag {
    
    public static var hint: String {
        "#EXT-X-ENDLIST"
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

extension EXT_X_ENDLIST: CustomStringConvertible {
    
    public var description: String {
        "EXT-X-ENDLIST()"
    }
}
