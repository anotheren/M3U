//
//  EXTM3U.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/25.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

public struct EXTM3U: Equatable {
    
    public init() { }
}

extension EXTM3U: EXTTag {
    
    public static var hint: String {
        "#EXTM3U"
    }
    
    public init?(lines: [String]) {
        guard lines[0].hasPrefix(Self.hint) else {
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
