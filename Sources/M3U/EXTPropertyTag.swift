//
//  EXTPropertyTag.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/27.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation
import OrderedCollections

protocol EXTPropertyTag: EXTTag {
    
    associatedtype EXTPropertyKey: Hashable
    
    var properties: OrderedDictionary<EXTPropertyKey, EXTPropertyValue> { get set }
}
