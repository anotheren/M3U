//
//  EXT-X-INDEPENDENT-SEGMENTS.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/25.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

public struct EXT_X_INDEPENDENT_SEGMENTS: Equatable {
    
    public init() { }
}

extension EXT_X_INDEPENDENT_SEGMENTS: EXTTag {
    
    public static var hint: String {
        "#EXT-X-INDEPENDENT-SEGMENTS"
    }
    
    public init?(lines: [String]) {
        guard lines[0].hasPrefix(EXT_X_INDEPENDENT_SEGMENTS.hint) else {
            return nil
        }
        self.init()
    }
    
    public var lines: [String] {
        [EXT_X_INDEPENDENT_SEGMENTS.hint]
    }
}

extension EXT_X_INDEPENDENT_SEGMENTS: CustomStringConvertible {
    
    public var description: String {
        "EXT-X-INDEPENDENT-SEGMENTS()"
    }
}
