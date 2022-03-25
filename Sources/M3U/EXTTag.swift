//
//  EXTTag.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/25.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation
 
public protocol EXTTag: CustomStringConvertible {
    
    static var hint: String { get }
    
    init?(content: String)
    var content: String { get }
}

extension EXTTag {
    
    public var description: String {
        content
    }
}
