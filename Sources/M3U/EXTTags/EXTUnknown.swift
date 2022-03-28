//
//  EXTUnknown.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/28.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

public struct EXTUnknown: Equatable {
    
    public let value: [String]
}

extension EXTUnknown: EXTTag {
    
    public static var hint: String {
        ""
    }
    
    public init(lines: [String]) {
        self.value = lines
    }
    
    public var lines: [String] {
        value
    }
}
