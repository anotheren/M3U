//
//  EXT-X-STREAM-INF.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/25.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

public struct EXT_X_STREAM_INF {
    

}

extension EXT_X_STREAM_INF: EXTTag {
    
    public static var hint: String {
        "#EXT-X-STREAM-INF"
    }
    
    public init?(content: String) {
        guard content.hasPrefix(EXT_X_STREAM_INF.hint) else {
            return nil
        }
        self.init()
    }
    
    public var content: String {
        EXT_X_STREAM_INF.hint
    }
}
