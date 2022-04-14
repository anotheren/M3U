//
//  EXTResolution.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/28.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

public struct EXTResolution: Equatable {
    
    public let width: Int
    public let height: Int
    
    public init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
}

extension EXTResolution {
    
    init?(string: String) {
        let items = string.split(separator: "x")
        guard items.count == 2, let width = Int(items[0]), let height = Int(items[1]) else {
            return nil
        }
        self.init(width: width, height: height)
    }
}

extension EXTResolution: CustomStringConvertible {
    
    public var description: String {
        "\(width)x\(height)"
    }
}
