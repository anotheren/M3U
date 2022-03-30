//
//  EXTByteRange.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/25.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

public struct EXTByteRange: Equatable {
    
    public let length: Int
    public let offset: Int
    
    public init(length: Int, offset: Int) {
        self.length = length
        self.offset = offset
    }
}

extension EXTByteRange {
    
    init?(string: String) {
        let items = string.split(separator: "@")
        guard items.count == 2, let length = Int(items[0]), let offset = Int(items[1]) else {
            return nil
        }
        self.init(length: length, offset: offset)
    }
}

extension EXTByteRange: CustomStringConvertible {
    
    public var description: String {
        "\(length)@\(offset)"
    }
}
