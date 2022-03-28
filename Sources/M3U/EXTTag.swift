//
//  EXTTag.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/25.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation
 
public protocol EXTTag {
    
    static var hint: String { get }
    
    init?(lines: [String])
    var lines: [String] { get }
}
