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
