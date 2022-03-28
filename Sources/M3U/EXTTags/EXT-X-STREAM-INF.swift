//
//  EXT-X-STREAM-INF.swift
//  M3U
//
//  Created by 刘栋 on 2022/3/25.
//  Copyright © 2022 anotheren.com. All rights reserved.
//

import Foundation

public struct EXT_X_STREAM_INF: Equatable {
    

}

extension EXT_X_STREAM_INF: EXTTag {
    
    public static var hint: String {
        "#EXT-X-STREAM-INF"
    }
    
    public init?(lines: [String]) {
        guard lines[0].hasPrefix(EXT_X_STREAM_INF.hint) else {
            return nil
        }
        self.init()
    }
    
    public var lines: [String] {
        [EXT_X_STREAM_INF.hint]
    }
}
