//
//  EXTAttributesTag.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/27.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

protocol EXTAttributesTag: EXTTag {
    
    var attributeList: EXTAttributeList { get set }
}
