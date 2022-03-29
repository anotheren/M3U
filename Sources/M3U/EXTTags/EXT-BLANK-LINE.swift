//
//  EXT-BLANK-LINE.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/28.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

public struct EXT_BLANK_LINE: Equatable {
    
    public init() { }
}

extension EXT_BLANK_LINE: EXTTag {
    
    public static var hint: String {
        "#EXT-BLANK-LINE"
    }
    
    public init?(lines: [String]) {
        guard lines[0].hasPrefix(EXT_BLANK_LINE.hint) else {
            return nil
        }
        self.init()
    }
    
    public var lines: [String] {
        [""]
    }
}

extension EXT_BLANK_LINE: CustomStringConvertible {
    
    public var description: String {
        "EXT-BLANK-LINE()"
    }
}
