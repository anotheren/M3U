//
//  EXTResolution.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/28.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

public struct EXTResolution: Equatable {
    
    public var width: Int
    public var height: Int
    
    public init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
}
