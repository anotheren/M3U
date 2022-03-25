//
//  EXTM3U.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/25.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

public struct EXTM3U {
    
    public init() { }
}

extension EXTM3U: EXTTag {
    
    public static var hint: String {
        "#EXTM3U"
    }
    
    public init?(content: String) {
        guard content.hasPrefix(EXTM3U.hint) else {
            return nil
        }
        self.init()
    }
    
    public var content: String {
        EXTM3U.hint
    }
}
