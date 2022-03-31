//
//  EXT-X-PLAYLIST-TYPE.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/30.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

/// EXT-X-PLAYLIST-TYPE
///
/// The EXT-X-PLAYLIST-TYPE tag provides mutability information about the
/// Media Playlist file.  It applies to the entire Media Playlist file.
/// It is OPTIONAL.
///
/// > https://datatracker.ietf.org/doc/html/rfc8216#section-4.3.3.5
///
public struct EXT_X_PLAYLIST_TYPE: Equatable {
    
    public var type: PlaylistType
    
    public init(type: PlaylistType) {
        self.type = type
    }
}

extension EXT_X_PLAYLIST_TYPE {
    
    public enum PlaylistType: String, Equatable, CustomStringConvertible {
        
        case vod   = "VOD"
        case event = "EVENT"
        
        public var description: String {
            rawValue
        }
    }
}

extension EXT_X_PLAYLIST_TYPE: EXTTag {
    
    public static var hint: String {
        "#EXT-X-PLAYLIST-TYPE"
    }
    
    public init?(lines: [String]) {
        let line = lines[0]
        guard line.hasPrefix(Self.hint) else {
            return nil
        }
        let startIndex = line.index(line.startIndex, offsetBy: Self.hint.count+1)
        let endIndex = line.endIndex
        let plainText = String(line[startIndex..<endIndex])
        guard let type = PlaylistType(rawValue: plainText) else {
            return nil
        }
        self.init(type: type)
    }
    
    public var lines: [String] {
        ["\(Self.hint):\(type)"]
    }
}

extension EXT_X_PLAYLIST_TYPE: CustomStringConvertible {
    
    public var description: String {
        "EXT-X-PLAYLIST-TYPE(TYPE:\(type))"
    }
}
 
