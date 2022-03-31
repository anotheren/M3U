//
//  EXT-UNKNOWN.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/28.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

public struct EXT_UNKNOWN: Equatable {
    
    private let content: [String]
}

extension EXT_UNKNOWN: EXTTag {
    
    public static var hint: String {
        "#EXT-UNKNOWN"
    }
    
    public init(lines: [String]) {
        self.content = lines
    }
    
    public var lines: [String] {
        content
    }
}

extension EXT_UNKNOWN: CustomStringConvertible {
    
    public var description: String {
        "EXT-UNKNOWN(content:\(content))"
    }
}
